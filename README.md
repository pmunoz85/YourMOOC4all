# Proyecto Fin de Grado

	Pedro Manuel Muñoz Morales
	pmunoz85@alumno.uned.es

	UNIVERSIDAD NACIONAL DE EDUCACIÓN A DISTANCIA (UNED)

	ESCUELA TÉCNICA SUPERIOR DE INGENIERÍA INFORMÁTICA

	Proyecto de Fin de Grado en Ingeniería Informática

	YourMOOC4all – Diseño inclusivo y retroalimentación útil de cursos MOOC para estudiantes con discapacidad

	Dirigido por: Francisco Iniesto Carrasco
	Codirigido por: Covadonga Rodrigo San Juan
	
	Curso: 2017-2018: 1ª Convocatoria

# Producción en Heroku

https://pmunoz85-alumno-uned-es.herokuapp.com/home/index?locale=es

# Objetivos

El objetivo de este proyecto es la creación de un portal Web, que sirva a los usuarios registrados la posibilidad de descubrir y evaluar cursos masivos abiertos en línea (MOOC, COMA), de reciente publicación en diferentes plataformas oferentes de este tipo de cursos (por definir, UNED COMA, edX, Coursera o FutureLearn), o incluso hacer una búsqueda de forma categorizada, relacionado con un tipo de curso en el que el usuario esté interesado, siempre teniendo en cuenta el punto de vista de la accesibilidad. 

El sistema va a ser una adaptación de páginas recomendatorias de cursos MOOC como Course Talk o MOOC - list, pero en este caso se evalúan aspectos relacionados con la experiencia en términos de accesibilidad y usabilidad del curso, incluyendo aspectos relacionados con el uso de tecnologías de asistencia, la disponibilidad de subtitulado en diversos idiomas, de lenguaje de signos, transcripciones y otros factores que influyan en el proceso educativo de aquellos estudiantes con discapacidad. 

Para la interfaz de usuario con la que se proveerá al portal Web, se debe hacer hincapié en la usabilidad y la accesibilidad, para que pueda ser usada por la mayor cantidad de personas posibles, atenuando cualquier discapacidad que pudiera tener el usuario en potencia. Debe destacar por su claridad, facilidad de uso y ser intuitiva.


 
# Método de desarrollo, fases del trabajo

El método utilizado para el desarrollo de este portal Web será un método ágil, mediante el cual se harán diferentes iteraciones de las fases de análisis, implementación y pruebas de las mismas, añadiendo más funcionalidades en cada iteración. El método ágil específico que se va a emplear, será Scrum. La motivación principal será la mejora recursiva del portal mediante la retroalimentación entre el desarrollador, en este caso particular es el alumno, y el cliente, en el caso que nos ocupa es el equipo docente. El proceso se dará por concluido cuando el portal Web cumpla con todas las especificaciones aportadas por el Equipo Docente.

El plan de trabajo se llevará a cabo en varias fases diferenciadas, algunas de ellas iteradas hasta lograr la especificación de requisitos. Son las siguientes:

## Investigación preliminar.

En esta fase recabamos toda la información necesaria para el desarrollo del portal Web. Se busca alcanzar un conocimiento óptimo de las herramientas y los recursos necesarios para llevar a cabo el proyecto. Recopilando y estudiando toda la bibliografía necesaria para la realización del mismo. Buena parte de la investigación se la llevará el motor de la aplicación, que de forma automatizada debe obtener información de las plataformas MOOC y evaluar la misma con herramientas de terceros.

## Análisis de requisitos.

En este apartado la mayor parte del esfuerzo recaerá en conocer todas las necesidades que tengan los usuarios de nuestra aplicación web, sobre todo se deben crear historias de usuario para todas las funcionalidades que creamos oportunas añadir, y así formarnos una idea adecuada de las necesidades del proyecto y el uso que se va a hacer de la aplicación Web. Así seremos capaces de desarrollar todas las funcionalidades necesarias para el correcto funcionamiento del mismo.

## Diseño del portal Web.

Aquí estudiaremos las diferentes alternativas de implementación para realizar los requisitos obtenidos en el apartado anterior. Decidiremos la estructura general que tendrá el portal, estructura de la base de datos que albergará la información necesaria para el sistema, la interfaz con el usuario y sus necesidades especiales para cada individuo, acotación del portal, etc.

## Implementación.

Una vez que sabemos qué funciones debe desempeñar nuestro portal y hemos decidido cómo vamos a organizar sus diversos apartados, es el momento de pasar a la etapa de implementación, donde llevaremos a cabo todo lo obtenido en el apartado anterior de diseño. 

## Fase de pruebas.

En esta fase se testeará la implementación realizada en la fase anterior, esto implica tanto test de unidad, como test de integración, pruebas alfa, beta y test de aceptación, para cada iteración de las implementaciones. Al final también se realizará un test al portal de forma completa.

## Subida y puesta en preproducción.

Cuando el proyecto se encuentre en la fase final, justo antes de la defensa del proyecto, se subirá a internet con el fin de que usuarios reales puedan probar el producto desarrollado. También servirá para evaluar la capacidad de la aplicación en cuanto a soporte de peticiones masivas y quizá aportar algo de balanceo de carga. 

## Preparación de la presentación del proyecto.

Una vez finalizado y probado el portal Web, se realizará la documentación necesaria, como por ejemplo la memoria y los manuales de usuario. También se preparará la presentación y defensa del proyecto.

# Las duraciones estimadas para la realización de cada una de las fases anteriormente descritas son las siguientes:

* Investigación preliminar. Duración estimada 2 semanas.
* Análisis de requisitos. Duración estimada 5 semanas.
* Diseño del portal Web. Duración estimada 6 semanas.
* Implementación. Duración estimada 4 semanas.
* Fase de pruebas. Duración estimada 6 semanas.
* Subida y puesta en preproducción. Duración estimada 3 semanas.
* Preparación de la presentación. Duración estimada 1 semanas.

 
# Medios a utilizar y breve justificación de la pertinencia de los mismos

La aplicación web será desarrollada íntegramente con herramientas de código abierto y servicios gratuitos en la nube: 

* Como lenguajes de maquetación se va a emplear HTML5 y CSS, al que se debe sumar Javascrip para la parte dinámica de la misma. Para ello el Famework Bootstrap es el más adecuado, el cual va a permitir que el diseño web sea adaptativo a los diferentes dispositivos actuales: ordenadores, tablets, móviles, etc. 

* El lenguaje usado para la lógica de negocio será Ruby en su versión 2.0 o superior, que al ser un lenguaje interpretado se adapta a los desarrollos web. Es un lenguaje dinámico y de código abierto enfocado en la simplicidad y la productividad. 

* Para el Framework se va a utilizar Ruby On Rails en su versión 4 o superior, Ruby on Rails es un entorno de desarrollo web de código abierto que está optimizado productividad sostenible.

* Para el apartado de bases de datos la indicada es MySql en su versión de código abierto. MySQL es un sistema de gestión de base de datos relacional (RDBMS), basado en lenguaje de consulta estructurado (SQL). El programa MySQL se usa como servidor a través del cual pueden conectarse múltiples usuarios y utilizarlo al mismo tiempo.

* Como gestor de versiones el indicado es Git. Este fue creado pensando en la eficiencia y la confiabilidad del mantenimiento de versiones de aplicaciones cuando éstas tienen un gran número de archivos de código fuente.

* El editor de texto para la programación será Sublime Text. Este es un potente y ligero editor de código multiplataforma.

* Para el alojamiento en la web en desarrollo se usará Heroku.  En el caso de montar nuestro propio servidor web, sería con un sistema operativo Ubuntu Server en su versión 17.4, con Apache para servir las páginas estáticas y Passenger para hacer de servidor de aplicaciones, procesar las páginas dinámicas escritas en Ruby convirtiendo estas en páginas estáticas.

* Para obtener la información de los proveedores MOOC se va a implementar una pasarela mediante el estándar Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH) que define el XML (formato, etiquetas,...) del contenido harvesteable.

# Referencias Bibliográficas.

Iniesto, Francisco and Rodrigo, Covadonga (2016). Can user recommendations be useful for improving MOOCs accessibility? A project for inclusive design and profitable feedback. In: Open Education Global Conference 2016, 11-13 April 2016, Krakow, Poland.  http://oro.open.ac.uk/46065/

Iniesto, F.; Rodrigo, C. Strategies for improving the level of accessibility in the design of
MOOC-based learning services. In: International Symposium on Computers in Education
(SIIE), Salamanca, Spain. (2016)

Iniesto, F.; Rodrigo, C. Can user recommendations be useful for improving MOOCs
accessibility? A project for inclusive design and profitable feedback. In: Open Education
Global Conference 2016, Krakow, Poland. (2016)

Yuan, L.; Powell, S.: MOOCs and disruptive innovation: Implications for Higher Education.
eLearning Papers, In-depth, 33, 2, 1-7 (2013)

Hill, P. Online Educational Delivery Models: A Descriptive View. Edu-cause Review, No
47(6), Pages 84-86. Retrieved from http://www.educause.edu/ir/library/pdf/ERM1263.pdf
(2012)

Yang, D.; Sinha, T.; Adamson, D.; Rose, C. P.: Turn on, tune in, drop out: Anticipating
student dropouts in massive open online courses. In Proceedings of the 2013 NIPS Data-
Driven Education Workshop (Vol. 10, p. 13) (2013).

Liyanagunawardena, T. R.; Parslow, P.; Williams, S.: Dropout: MOOC participants’
perspective. Proceedings of the European MOOC Stakeholder Summit 2014 (2014): 95-
100.

de Waard, I., Gallagher, M. S., Zelezny-Green, R., Czerniewicz, L., Downes, S., Kukulska-
Hulme, A., & Willems, J.: Challenges for conceptualising EU MOOC for vulnerable learner
groups. Proceedings of the European MOOC Stakeholder Summit 2014 (2014): 33-42.

CAST. Universal Design for Learning Guidelines version 2.0. Wakefield, MA (2011)

Lucas Carlson, Leonard Richardson: Curso de Ruby, Ruby Cookbook (2009)

Obie Fernandez, Kevin Faustino and Vitaly Kushner: The Rails 4 Way (2014)

Bruce A. Tate, Curt Hibbs: Ruby on Rails (2009)

Santiago Ponce Moreno: Ruby on Rails. Desarrollo práctico de aplicaciones web (2013)

Sam Ruby, Dave Thomas, David Heinemeier Hansson; Traducción de Teresa Samaniego
Cabañas: Desarrollo Web con Rails (2009)

José López Quijado: Domine HTML y DHTML (2007)

Juan Diego Gauchat: El gran libro de HTML5, CSS3 y JavaScript (2012)

