<?php

namespace Fias\DataSource;

interface DataSource
{
    public function getRows($maxCount = 1000);
}
