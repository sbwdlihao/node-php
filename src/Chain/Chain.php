<?php

namespace BitWasp\Bitcoin\Node\Chain;


use BitWasp\Bitcoin\Math\Math;
use BitWasp\Bitcoin\Node\Index;
use BitWasp\Buffertools\Buffer;

/**
 * This class retains all of this in memory. It must be
 * rebuilt on startup.
 */
class Chain
{
    /**
     * @var Index\Headers
     */
    private $headers;

    /**
     * @var BlockIndex
     */
    private $index;

    /**
     * @var ChainCache
     */
    private $chainCache;

    /**
     * @var Math
     */
    private $math;

    /**
     * @param string[] $map
     * @param BlockIndex $index
     * @param Index\Headers $headers
     * @param Math $math
     */
    public function __construct(array $map, BlockIndex $index, Index\Headers $headers, Math $math)
    {
        $this->math = $math;
        $this->chainCache = new ChainCache($map);
        $this->index = $index;
        $this->headers = $headers;
    }

    /**
     * @return BlockIndex
     */
    public function getIndex()
    {
        return $this->index;
    }

    /**
     * @return ChainCache
     */
    public function getChainCache()
    {
        return $this->chainCache;
    }

    /**
     * @param Buffer $hash
     * @return bool
     */
    public function containsHash(Buffer $hash)
    {
        return $this->chainCache->containsHash($hash);
    }

    /**
     * @param Buffer $hash
     * @return int
     */
    public function getHeightFromHash(Buffer $hash)
    {
        return $this->chainCache->getHeight($hash);
    }

    /**
     * @param $height
     * @return Buffer
     */
    public function getHashFromHeight($height)
    {
        return $this->chainCache->getHash($height);
    }

    /**
     * @param Buffer $hash
     * @return BlockIndex
     */
    public function fetchIndex(Buffer $hash)
    {
        if (!$this->chainCache->containsHash($hash)) {
            throw new \RuntimeException('Index by this hash not known');
        }

        return $this->headers->fetch($hash);
    }

    /**
     * @param BlockIndex $index
     */
    public function updateTip(BlockIndex $index)
    {
        if ($this->index->getHash() !== $index->getHeader()->getPrevBlock()) {
            throw new \RuntimeException('Header: Header does not extend this chain');
        }

        if (($index->getHeight() - 1) != $this->index->getHeight()) {
            throw new \RuntimeException('Header: Incorrect chain height');
        }

        $this->chainCache->add($index);
        $this->index = $index;
    }

    /**
     * @param int $height
     * @return BlockIndex
     */
    public function fetchAncestor($height)
    {
        return $this->fetchIndex($this->getHashFromHeight($height));
    }
}