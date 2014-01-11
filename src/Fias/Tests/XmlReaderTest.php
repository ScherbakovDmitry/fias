<?php

namespace Fias\Tests;

use Fias\XmlReader;

class XmlReaderTest extends \PHPUnit_Framework_TestCase
{
    /** @var XMLReader */
    private $reader;

    protected function setUp()
    {
        $this->reader = new XMLReader(
            __DIR__ . '/resources/readerTest.xml',
            'Computer',
            array(
                'id',
                'madeIn',
                'fakeAttribute'
            ),
            array(
                'available' => 1,
        ));
    }

    public function testRead()
    {
        $rows = $this->reader->getRows();

        $this->assertEquals(2, count($rows));
        $this->assertEquals('USA', $rows[1]['madeIn']);
        $this->assertEquals(null, $rows[0]['fakeAttribute']);
        $this->assertTrue(!isset($rows[0]['title']));
    }

    public function testReadWithCount()
    {
        $this->assertEquals(1, count($this->reader->getRows(1)));
        $this->assertEquals(1, count($this->reader->getRows(1)));
        $this->assertEquals(0, count($this->reader->getRows(1)));
    }

    /**
     * @expectedException \LogicException
     * @expectedExceptionMessage количества
     */
    public function testBadCount()
    {
        $this->reader->getRows(0);
    }
}
