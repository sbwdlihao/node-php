<?php

namespace BitWasp\Bitcoin\Node\Console;


use BitWasp\Bitcoin\Node\Console\Commands\DbReset;
use BitWasp\Bitcoin\Node\Console\Commands\NodeInfo;
use BitWasp\Bitcoin\Node\Console\Commands\PrintConfig;
use BitWasp\Bitcoin\Node\Console\Commands\StartNode;
use BitWasp\Bitcoin\Node\Console\Commands\StopNode;
use Symfony\Component\Console\Application as ConsoleApplication;

class Application extends ConsoleApplication
{
    protected function getDefaultCommands()
    {
        $commands = parent::getDefaultCommands();
        $commands[] = new StartNode();
        $commands[] = new StopNode();
        $commands[] = new NodeInfo();
        $commands[] = new PrintConfig();
        $commands[] = new DbReset();
        return $commands;
    }
}
