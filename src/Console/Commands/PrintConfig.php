<?php

namespace BitWasp\Bitcoin\Node\Console\Commands;


use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class PrintConfig extends AbstractCommand
{
    /**
     *
     */
    protected function configure()
    {
        $this
            ->setName('print-config')
            ->setDescription('Output a blank configuration file');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    public function execute(InputInterface $input, OutputInterface $output)
    {
        $output->write('[db]
# SQL configuration.
# The following 5 values are required:
driver=mysql
host=
username=
password=
database=

# General Configuration
[config]
# Should the client listen for incoming connections?
listen=0

');
        return 0;
    }
}