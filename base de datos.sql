CREATE SCHEMA IF NOT EXISTS `proyecto` DEFAULT CHARACTER SET utf8 ;
USE `proyecto` ;

Drop Table if EXISTS `Alumno`;
Drop Table if EXISTS `Maestro`;
Drop Table if EXISTS `Vehiculo`;
Drop Table if EXISTS `Asignacion`;
Drop Table if EXISTS `Curso`;
Drop Table if EXISTS `Matricula`;

CREATE TABLE IF NOT EXISTS `Alumno` (
  `Id` INT AUTO_INCREMENT PRIMARY KEY,
  `NCedula` VARCHAR(20) NOT NULL,
  `Nombre` VARCHAR(25) NOT NULL,
  `Apellido` VARCHAR(25) NOT NULL,
  `Telefono` VARCHAR(10) NOT NULL,
  `Direccion` VARCHAR(100) NOT NULL
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Maestro` (
  `Id` INT AUTO_INCREMENT PRIMARY KEY,
  `Licencia` VARCHAR(25) NOT NULL,
  `NCedula` VARCHAR(20) NOT NULL,
  `Nombre` VARCHAR(25) NOT NULL,
  `Apellido` VARCHAR(25) NOT NULL,
  `Telefono` VARCHAR(10) NOT NULL,
  `Direccion` VARCHAR(100) NOT NULL
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Vehiculo` (
  `Id` INT AUTO_INCREMENT PRIMARY KEY,
  `Marca` VARCHAR(15) NOT NULL,
  `Modelo` VARCHAR(15) NOT NULL,
  `Color` VARCHAR(15) NOT NULL,
  `Circulacion` VARCHAR(20) NOT NULL,
  `Matricula` VARCHAR(10) NOT NULL
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Asignacion` (
  `Id` INT AUTO_INCREMENT PRIMARY KEY,
  `MaestroID` INT NOT NULL,
  `VehiculoID` INT NOT NULL,
  CONSTRAINT `asignacion_maestrofk`
    FOREIGN KEY (`MaestroID`)
    REFERENCES `Maestro` (`Id`),
  CONSTRAINT `asignacion_vehiculofk`
    FOREIGN KEY (`VehiculoID`)
    REFERENCES `Vehiculo` (`Id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Curso` (
  `Id` INT AUTO_INCREMENT PRIMARY KEY,
  `Nombre` VARCHAR(25) NOT NULL,
  `HTeorica` INT NOT NULL,
  `HPractica` INT NOT NULL,
  `Costo` float NOT NULL
  
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Matricula` (
  `Id` INT AUTO_INCREMENT PRIMARY KEY,
  `AlumnoID` INT NOT NULL,
  `MaestroID` INT NOT NULL,
  `CursoID` INT NOT NULL,
  `Nota` INT,
  `Horario` VARCHAR(60),
  CONSTRAINT `matricula_alumnofk`
    FOREIGN KEY (`AlumnoID`)
    REFERENCES `Alumno` (`Id`),
  CONSTRAINT `matricula_maestrofk`
    FOREIGN KEY (`MaestroID`)
    REFERENCES `Maestro` (`Id`),
  CONSTRAINT `matricula_cursofk`
    FOREIGN KEY (`CursoID`)
    REFERENCES `Curso` (`Id`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;