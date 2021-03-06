<?php

namespace BitWasp\Bitcoin\Node\Chain;



use BitWasp\Buffertools\Buffer;

class ChainCache
{
    /**
     * @var string[]
     */
    private $hashByHeight = [];

    /**
     * @var int[]
     */
    private $heightByHash = [];

    /**
     * Must be initialized with a list of hashes in binary representation
     * @param array $hashes
     */
    public function __construct(array $hashes)
    {
        $this->hashByHeight = $hashes;
        $this->heightByHash = array_flip($hashes);
    }

    /**
     * @param Buffer $hash
     * @return bool
     */
    public function containsHash(Buffer $hash)
    {
        return array_key_exists($hash->getBinary(), $this->heightByHash);
    }

    /**
     * @param Buffer $hash
     * @return int
     */
    public function getHeight(Buffer $hash)
    {
        if ($this->containsHash($hash)) {
            return $this->heightByHash[$hash->getBinary()];
        }

        throw new \RuntimeException('Hash not found');
    }

    /**
     * @param int $height
     * @throws \RuntimeException
     * @return Buffer
     */
    public function getHash($height)
    {
        if (!array_key_exists($height, $this->hashByHeight)) {
            throw new \RuntimeException('ChainCache: index at this height ('.$height.') not known');
        }

        return new Buffer($this->hashByHeight[$height], 32);
    }

    /**
     * @param BlockIndex $index
     */
    public function add(BlockIndex $index)
    {
        if ($index->getHeader()->getPrevBlock() !== $this->getHash($index->getHeight() - 1)->getHex()) {
            throw new \RuntimeException('ChainCache: New BlockIndex does not refer to last');
        }

        $binary = hex2bin($index->getHash());
        $this->hashByHeight[] = $binary;
        $this->heightByHash[$binary] = $index->getHeight();
    }

    /**
     * @param int $endHeight
     * @return ChainCache
     */
    public function subset($endHeight)
    {
        if ($endHeight > count($this->hashByHeight)) {
            throw new \InvalidArgumentException('ChainCache::subset() - end height exceeds size of this cache');
        }

        return new self(array_slice($this->hashByHeight, 0, $endHeight));
    }
}