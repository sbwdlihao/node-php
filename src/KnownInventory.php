<?php

namespace BitWasp\Bitcoin\Node;


use BitWasp\Bitcoin\Networking\Structure\Inventory;

class KnownInventory
{
    private $storage = [];

    /**
     * @param Inventory $inventory
     */
    public function save(Inventory $inventory)
    {
        $this->storage[$inventory->getHash()->getBinary()] = $inventory->getType();
    }

    /**
     * @param Inventory $inventory
     * @return bool
     */
    public function check(Inventory $inventory)
    {
        return isset($this->storage[$inventory->getHash()->getBinary()]);
    }
}
