<?php

namespace en2portr3s\controller;

use en2portr3s\library\View;

class InicioController {

    public function indexAction() {
        return new View('inicio');
    }

}
