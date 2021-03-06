--
-- Database: 'en2portr3s'
--

CREATE DATABASE IF NOT EXISTS en2portr3s
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

USE en2portr3s;

-- --------------------------------------------------------

--
-- Table structure for table 'person'
--

CREATE TABLE IF NOT EXISTS person (
    id INT(10) NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(64) NOT NULL,
    phone VARCHAR(16) NOT NULL,
    birthdate TIMESTAMP NOT NULL,

    PRIMARY KEY (id),
    UNIQUE KEY (email)
);

-- --------------------------------------------------------

--
-- Table structure for table 'account'
--

CREATE TABLE IF NOT EXISTS account (
    id INT(10) NOT NULL AUTO_INCREMENT,
    username VARCHAR(36) NOT NULL,
    pass VARCHAR(32) NOT NULL,
    kind VARCHAR(24) DEFAULT 'normal',
    status VARCHAR(24) DEFAULT 'activo',
    since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    person_id INT(10) NOT NULL,

    PRIMARY KEY (id),
    INDEX (person_id),

    FOREIGN KEY (person_id)
    REFERENCES person(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table 'question'
--

CREATE TABLE IF NOT EXISTS question (
    id INT(10) NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(36) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(64) NOT NULL,
    content VARCHAR(800) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pendiente',
    since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

-- --------------------------------------------------------

--
-- Table structure for table 'suggestion'
--

CREATE TABLE IF NOT EXISTS suggestion (
    id INT(10) NOT NULL AUTO_INCREMENT,
    content VARCHAR(800) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pendiente',
    since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

-- --------------------------------------------------------

--
-- Table structure for table 'page'
--

CREATE TABLE IF NOT EXISTS page (
    id INT(10) NOT NULL AUTO_INCREMENT,
    label VARCHAR(16) NOT NULL,
    since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

-- --------------------------------------------------------

--
-- Table structure for table 'content'
--

CREATE TABLE IF NOT EXISTS content (
    id INT(10) NOT NULL AUTO_INCREMENT,
    kind VARCHAR(16) NOT NULL,
    page_id INT(10) NOT NULL,

    PRIMARY KEY (id),
    INDEX (page_id),

    FOREIGN KEY (page_id)
    REFERENCES page(id)
    ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table 'image'
--

CREATE TABLE IF NOT EXISTS image (
    id INT(10) NOT NULL AUTO_INCREMENT,
    url VARCHAR(255) NOT NULL,
    alt VARCHAR(128) NOT NULL,
    since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    content_id INT(10) NOT NULL,

    PRIMARY KEY (id),
    INDEX (content_id),

    FOREIGN KEY (content_id)
    REFERENCES content(id)
    ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table 'text_entry'
--

CREATE TABLE IF NOT EXISTS text_entry (
    id INT(10) NOT NULL AUTO_INCREMENT,
    body VARCHAR(21820) NOT NULL,
    lang_code VARCHAR(10) NOT NULL,
    since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    content_id INT(10) NOT NULL,

    PRIMARY KEY (id),
    INDEX (content_id),

    FOREIGN KEY (content_id)
    REFERENCES content(id)
    ON UPDATE CASCADE
);
