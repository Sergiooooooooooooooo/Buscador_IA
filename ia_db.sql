-- Crear tabla de categorías
CREATE TABLE IF NOT EXISTS categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Crear tabla de soluciones de IA
CREATE TABLE IF NOT EXISTS solucion_ia (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    categoria_id INT NOT NULL,
    precio VARCHAR(50) NOT NULL, -- Precio: gratis, pago, freemium
    enlace VARCHAR(255), -- Enlace a la solución
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

-- Crear tabla para almacenar búsquedas de usuarios
CREATE TABLE IF NOT EXISTS historial_busquedas (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(255) NOT NULL,
    busqueda VARCHAR(255) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla para registrar clics en soluciones para recomendaciones
CREATE TABLE IF NOT EXISTS historial_recomendaciones (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(255) NOT NULL,
    solucion_id INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (solucion_id) REFERENCES solucion_ia(id)
);

-- Crear índices para optimización en la tabla solucion_ia
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_nombre_solucion') THEN
        CREATE INDEX idx_nombre_solucion ON solucion_ia (nombre);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_categoria_solucion') THEN
        CREATE INDEX idx_categoria_solucion ON solucion_ia (categoria_id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_precio_solucion') THEN
        CREATE INDEX idx_precio_solucion ON solucion_ia (precio);
    END IF;
END $$; 

-- Crear tabla descripcion_ampliada
CREATE TABLE IF NOT EXISTS descripcion_ampliada (
    id SERIAL PRIMARY KEY,
    solucion_id INT NOT NULL, -- Relación con solucion_ia
    descripcion_ampliada CHARACTER VARYING(1000) NOT NULL, -- Campo para la descripción ampliada
    FOREIGN KEY (solucion_id) REFERENCES solucion_ia(id) -- Clave foránea
);

-- Insertar categorías
INSERT INTO categoria (nombre) VALUES
('IA de Texto'),
('IA de Generación de Imágenes'),
('IA de Análisis de Datos'),
('IA para Matemáticas');

-- Insertar soluciones de IA con precios: gratis, pago, freemium
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
-- IA de Texto
('DeepAI Text Generator', 'Generador avanzado de textos basado en IA.', 1, 'freemium', 'https://deepai.org/text-generator'),
('Narrato AI', 'Plataforma de IA para narrativas creativas.', 1, 'pago', 'https://narrato.ai/'),
('Writesonic', 'Asistente de escritura para blogs y contenido.', 1, 'gratis', 'https://writesonic.com/'),
('AI21 Studio', 'Generador de texto impulsado por la última tecnología IA.', 1, 'freemium', 'https://ai21.com/studio/'),
('Frase.io', 'Herramienta de contenido para mejorar SEO.', 1, 'pago', 'https://www.frase.io/'),
('Scalenut', 'IA para investigación y generación de contenido.', 1, 'gratis', 'https://www.scalenut.com/'),
('Anyword', 'Generador de textos optimizados por IA.', 1, 'pago', 'https://anyword.com/'),
('ContentBot', 'Creador de contenido para escritores y negocios.', 1, 'gratis', 'https://contentbot.ai/'),
('Copysmith', 'Solución IA para contenido empresarial.', 1, 'freemium', 'https://copysmith.ai/'),
('Text Blaze', 'Extensión IA para plantillas de texto.', 1, 'gratis', 'https://blaze.today/'),

-- IA de Generación de Imágenes
('Artbreeder AI', 'Generador de arte colaborativo.', 2, 'freemium', 'https://artbreeder.com/'),
('Fotor', 'Generador de imágenes y edición con IA.', 2, 'gratis', 'https://www.fotor.com/'),
('Canva AI', 'Diseño gráfico potenciado por IA.', 2, 'pago', 'https://www.canva.com/'),
('DeepArt.io', 'Transformación de fotos en arte digital.', 2, 'gratis', 'https://deepart.io/'),
('Dream by Wombo', 'Creador de arte impulsado por IA.', 2, 'pago', 'https://www.wombo.art/'),
('Pixelz AI', 'Plataforma de edición de imágenes para e-commerce.', 2, 'freemium', 'https://www.pixelz.com/'),
('Artomatix', 'Generación de texturas para videojuegos.', 2, 'pago', 'https://artomatix.com/'),
('Runway ML', 'Generador multimedia impulsado por IA.', 2, 'gratis', 'https://runwayml.com/'),
('AI Painter', 'Creador de pinturas digitales.', 2, 'freemium', 'https://aipainter.com/'),
('PhotoAI', 'Editor de fotos automático con IA.', 2, 'gratis', 'https://photoai.com/'),

-- IA de Análisis de Datos
('BigML', 'Plataforma de aprendizaje automático simplificada.', 3, 'gratis', 'https://bigml.com/'),
('SAS Viya', 'Herramienta avanzada de análisis de datos.', 3, 'freemium', 'https://www.sas.com/'),
('Zoho Analytics', 'Plataforma de análisis de datos en la nube.', 3, 'pago', 'https://www.zoho.com/analytics/'),
('AWS SageMaker', 'Plataforma de aprendizaje automático en la nube.', 3, 'freemium', 'https://aws.amazon.com/sagemaker/'),
('Google AutoML', 'Plataforma automatizada de modelos de IA.', 3, 'gratis', 'https://cloud.google.com/automl/'),
('IBM Watson Analytics', 'Análisis avanzado impulsado por IA.', 3, 'pago', 'https://www.ibm.com/watson'),
('H2O Driverless AI', 'Plataforma de predicción automatizada.', 3, 'freemium', 'https://www.h2o.ai/'),
('C3 AI', 'Plataforma empresarial para análisis y aprendizaje.', 3, 'pago', 'https://c3.ai/'),
('PowerBI con IA', 'Visualización y predicción basada en IA.', 3, 'gratis', 'https://powerbi.microsoft.com/'),
('Dataiku', 'Plataforma colaborativa de análisis de datos.', 3, 'freemium', 'https://www.dataiku.com/'),

-- IA para Matemáticas
('Mathpix Snip', 'Reconocimiento y análisis de ecuaciones.', 4, 'gratis', 'https://mathpix.com/'),
('Desmos', 'Calculadora gráfica avanzada en línea.', 4, 'gratis', 'https://www.desmos.com/'),
('Microsoft Math Solver', 'Solución automática de problemas matemáticos.', 4, 'gratis', 'https://math.microsoft.com/'),
('Equation Solver', 'Resolución automática de ecuaciones algebraicas.', 4, 'pago', 'https://www.equationsolver.com/'),
('StackMath', 'Plataforma de aprendizaje matemático con IA.', 4, 'freemium', 'https://stackmath.com/'),
('Math Solver AI', 'Asistente matemático avanzado.', 4, 'gratis', 'https://mathsolver.ai/'),
('Wyzant Math Tutor', 'Tutor personalizado de matemáticas.', 4, 'pago', 'https://www.wyzant.com/'),
('Integral Calculator', 'Calculadora avanzada de integrales.', 4, 'gratis', 'https://www.integral-calculator.com/'),
('SymPy', 'Biblioteca de álgebra simbólica.', 4, 'gratis', 'https://www.sympy.org/'),
('Alpha Tutor', 'Asistente interactivo para aprender álgebra.', 4, 'freemium', 'https://www.alphatutor.com/'); 

-- Insertar descripciones ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(1, 'DeepAI Text Generator es una herramienta avanzada para generar textos de forma automática utilizando la inteligencia artificial. Permite crear contenido de manera rápida y con alta calidad para diferentes aplicaciones, desde blogs hasta descripciones de productos.'),
(2, 'Narrato AI es una plataforma diseñada para ayudar a los creadores de contenido a generar narrativas y guiones mediante inteligencia artificial. Con potentes herramientas de IA, facilita la creación de historias cautivadoras.'),
(3, 'Writesonic es una plataforma ideal para escribir artículos, blogs y contenido de marketing. Ofrece generación de textos optimizados con IA, ayudando a mejorar la productividad de los redactores y equipos de marketing.'),
(4, 'AI21 Studio es una poderosa herramienta de generación de texto que utiliza modelos avanzados de IA para crear contenido interactivo y dinámico, optimizada para aplicaciones comerciales y creativas.'),
(5, 'Frase.io es una plataforma especializada en la optimización de contenido para SEO, proporcionando herramientas para crear textos que mejoren el posicionamiento en buscadores utilizando inteligencia artificial.'),
(6, 'Scalenut es una plataforma que combina IA y SEO para generar contenido de alta calidad y optimizado para marketing digital, ayudando a los usuarios a escalar su presencia en línea.'),
(7, 'Anyword es una solución avanzada de generación de contenido que utiliza inteligencia artificial para crear textos de alta conversión, especialmente útil para campañas publicitarias y marketing de contenido.'),
(8, 'ContentBot es un asistente basado en IA para crear contenido de manera más rápida y eficiente. Su enfoque está en ayudar a los escritores a generar textos persuasivos y bien estructurados.'),
(9, 'Copysmith es una herramienta de IA enfocada en la creación de contenido empresarial. Ofrece soluciones para redacción de anuncios, copias para sitios web y contenido de marketing con resultados optimizados.'),
(10, 'Text Blaze es una extensión para navegador que utiliza IA para automatizar la creación de plantillas y respuestas rápidas, permitiendo a los usuarios mejorar su productividad en la redacción de textos repetitivos.'),
(11, 'Artbreeder AI es una plataforma de creación de arte colaborativo que utiliza IA para permitir la combinación de imágenes y estilos, brindando a los usuarios un nuevo nivel de creatividad en el diseño visual.'),
(12, 'Fotor es una herramienta de edición de imágenes en línea que combina inteligencia artificial con potentes herramientas de edición para mejorar fotos de manera rápida y profesional.'),
(13, 'Canva AI es una plataforma que potencia el diseño gráfico mediante inteligencia artificial, ofreciendo herramientas automáticas para la creación de imágenes, presentaciones, carteles y más.'),
(14, 'DeepArt.io utiliza IA para transformar fotos comunes en obras de arte digital, emulando estilos artísticos de famosos pintores y artistas, permitiendo una personalización única en cada obra.'),
(15, 'Dream by Wombo es una aplicación que genera arte visual utilizando inteligencia artificial. Los usuarios pueden ingresar cualquier descripción y obtener una interpretación artística única y personalizada.'),
(16, 'Pixelz AI es una plataforma especializada en la edición de imágenes para e-commerce, utilizando IA para mejorar la calidad de las fotos de productos y optimizarlas para su venta en línea.'),
(17, 'Artomatix utiliza inteligencia artificial para generar texturas realistas y optimizadas para videojuegos, brindando soluciones de diseño que ahorran tiempo y recursos en la creación de mundos virtuales.'),
(18, 'Runway ML es una plataforma de herramientas creativas que aprovecha el poder de la inteligencia artificial para generar y editar multimedia, ideal para diseñadores y creadores de contenido visual.'),
(19, 'AI Painter es un generador de pinturas digitales que utiliza IA para crear arte visual completamente original basado en las descripciones proporcionadas por el usuario.'),
(20, 'PhotoAI es un editor de fotos automático que utiliza inteligencia artificial para mejorar imágenes de manera automática, ajustando colores, iluminación y otros parámetros para obtener una imagen de alta calidad.'),
(21, 'BigML es una plataforma de aprendizaje automático que facilita la creación y uso de modelos predictivos para usuarios sin experiencia técnica, proporcionando una interfaz intuitiva para el análisis de datos.'),
(22, 'SAS Viya es una herramienta avanzada de análisis de datos que utiliza inteligencia artificial para ayudar a las empresas a obtener información valiosa de grandes volúmenes de datos y optimizar su toma de decisiones.'),
(23, 'Zoho Analytics es una plataforma de análisis de datos en la nube que permite a los usuarios crear informes y paneles interactivos con capacidades avanzadas de inteligencia artificial para la predicción de tendencias.'),
(24, 'AWS SageMaker es un servicio de Amazon Web Services para la creación, entrenamiento e implementación de modelos de aprendizaje automático, utilizando herramientas avanzadas de IA para mejorar la eficiencia empresarial.'),
(25, 'Google AutoML es una plataforma de Google que permite a los usuarios crear modelos personalizados de aprendizaje automático sin necesidad de experiencia previa en codificación, utilizando IA avanzada.'),
(26, 'IBM Watson Analytics es una solución de análisis de datos empresarial impulsada por inteligencia artificial que permite la visualización de datos, análisis predictivo y generación de informes para facilitar la toma de decisiones.'),
(27, 'H2O Driverless AI es una plataforma automatizada de IA que facilita la construcción de modelos predictivos con un enfoque en la facilidad de uso, lo que permite a las empresas mejorar sus procesos con datos.'),
(28, 'C3 AI es una plataforma de análisis y aprendizaje automático para empresas que aprovecha la inteligencia artificial para ofrecer soluciones personalizadas de predicción y optimización.'),
(29, 'PowerBI con IA es una herramienta de visualización de datos que permite crear informes y paneles interactivos con capacidades avanzadas de IA para predecir tendencias y mejorar el análisis de datos.'),
(30, 'Dataiku es una plataforma colaborativa de análisis de datos que permite a los equipos construir y desplegar modelos de aprendizaje automático, utilizando IA para mejorar la toma de decisiones empresariales.'),
(31, 'Mathpix Snip es una herramienta que utiliza IA para convertir imágenes de ecuaciones matemáticas en código LaTeX, permitiendo a los usuarios trabajar con ecuaciones en formato digital.'),
(32, 'Desmos es una calculadora gráfica avanzada en línea que ayuda a los usuarios a visualizar funciones matemáticas y realizar análisis gráficos, con una interfaz fácil de usar y potentes herramientas de IA.'),
(33, 'Microsoft Math Solver es una aplicación que resuelve ecuaciones matemáticas utilizando IA, proporcionando soluciones paso a paso y explicaciones detalladas para problemas de álgebra, cálculo y más.'),
(34, 'Equation Solver es una herramienta en línea que resuelve ecuaciones algebraicas automáticamente utilizando algoritmos avanzados de IA, permitiendo soluciones rápidas y precisas.'),
(35, 'StackMath es una plataforma de aprendizaje de matemáticas que utiliza IA para ayudar a los estudiantes a resolver problemas matemáticos mediante un enfoque interactivo y personalizado.'),
(36, 'Math Solver AI es un asistente matemático que utiliza IA para ayudar a los usuarios a resolver problemas matemáticos complejos, proporcionando soluciones detalladas y explicaciones paso a paso.'),
(37, 'Wyzant Math Tutor es una plataforma de tutoría en línea que utiliza IA para conectar a los estudiantes con tutores especializados en matemáticas, facilitando el aprendizaje personalizado.'),
(38, 'Integral Calculator es una calculadora avanzada que permite resolver integrales de manera rápida, utilizando algoritmos matemáticos y capacidades de IA para optimizar la solución.'),
(39, 'SymPy es una biblioteca de álgebra simbólica que permite realizar cálculos matemáticos simbólicos de manera eficiente y rápida, siendo especialmente útil para matemáticos y científicos.'),
(40, 'Alpha Tutor es una plataforma interactiva para aprender álgebra que utiliza inteligencia artificial para personalizar la experiencia de aprendizaje de acuerdo con las necesidades y el progreso del estudiante.');

INSERT INTO categoria (nombre) VALUES
('IA para Videojuegos'),
('IA de Reconocimiento de Voz'),
('IA para Educación'),
('IA para Finanzas'),
('IA para Marketing');

--videojuegos--
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Modbox AI', 'Herramienta de IA para crear mundos virtuales en videojuegos.', 5, 'freemium', 'https://modbox.ai/'),
('Kynapse', 'Motor de IA para simulaciones y videojuegos.', 5, 'pago', 'https://www.kynapse.com/'),
('Promethean AI', 'Generador automático de entornos para videojuegos.', 5, 'freemium', 'https://www.prometheanai.com/'),
('GameGAN', 'Generador de videojuegos basado en redes generativas adversariales.', 5, 'gratis', 'https://gamegan.ai/'),
('Gamelab AI', 'Asistente para la creación de mecánicas de juego.', 5, 'gratis', 'https://gamelab.ai/');

INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(41, 'Modbox AI permite a los desarrolladores y entusiastas crear mundos virtuales personalizados en videojuegos. Con herramientas de IA intuitivas, facilita la generación de entornos y dinámicas interactivas.'),
(42, 'Kynapse es un motor de inteligencia artificial que se utiliza en videojuegos y simulaciones avanzadas. Ofrece soluciones de navegación, comportamiento y toma de decisiones para NPCs.'),
(43, 'Promethean AI es una herramienta revolucionaria que utiliza IA para diseñar entornos de videojuegos de manera automática, acelerando el proceso de creación y mejorando la calidad de los gráficos.'),
(44, 'GameGAN es un proyecto innovador que emplea redes generativas adversariales para crear videojuegos automáticamente. Ideal para desarrolladores que buscan explorar IA generativa.'),
(45, 'Gamelab AI es un asistente para el diseño de mecánicas de juego. Integra IA para proponer dinámicas novedosas y analizar la jugabilidad de los prototipos.');

--voz--
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Speechmatics', 'Reconocimiento de voz avanzado para múltiples idiomas.', 6, 'pago', 'https://www.speechmatics.com/'),
('Rev AI', 'Plataforma de transcripción y reconocimiento de voz.', 6, 'freemium', 'https://www.rev.ai/'),
('AssemblyAI', 'API de reconocimiento de voz para desarrolladores.', 6, 'freemium', 'https://www.assemblyai.com/'),
('Otter.ai', 'Transcripciones automáticas con IA.', 6, 'gratis', 'https://otter.ai/'),
('Voiceitt', 'Reconocimiento de voz adaptado para discapacidades del habla.', 6, 'pago', 'https://www.voiceitt.com/');
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(46, 'Speechmatics ofrece soluciones de reconocimiento de voz de última generación para transcripción y análisis en múltiples idiomas y contextos.'),
(47, 'Rev AI proporciona una API robusta para transcripción y análisis de voz, adaptada para desarrolladores y empresas de cualquier escala.'),
(48, 'AssemblyAI permite integrar reconocimiento de voz avanzado en aplicaciones a través de una API simple y potente. Soporta múltiples idiomas y formatos de audio.'),
(49, 'Otter.ai es una herramienta accesible para convertir conversaciones en texto en tiempo real. Ideal para reuniones, entrevistas y notas personales.'),
(50, 'Voiceitt utiliza IA para reconocer y transcribir voces con patrones no convencionales, proporcionando accesibilidad a personas con discapacidades del habla.');


--educacion--
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('ScribeSense', 'Herramienta de corrección automática de exámenes.', 7, 'freemium', 'https://www.scribesense.com/'),
('Knewton', 'Plataforma personalizada de aprendizaje adaptativo.', 7, 'pago', 'https://www.knewton.com/'),
('DreamBox Learning', 'Educación matemática impulsada por IA.', 7, 'freemium', 'https://www.dreambox.com/'),
('Smart Sparrow', 'Herramienta para diseñar cursos adaptativos.', 7, 'gratis', 'https://www.smartsparrow.com/'),
('Carnegie Learning', 'Software de aprendizaje de matemáticas y lenguaje.', 7, 'pago', 'https://www.carnegielearning.com/');

INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(51, 'ScribeSense automatiza la corrección de exámenes y trabajos escritos. Reconoce texto manuscrito y lo evalúa con precisión.'),
(52, 'Knewton utiliza algoritmos adaptativos para personalizar el aprendizaje de cada estudiante, maximizando la retención de conocimientos.'),
(53, 'DreamBox Learning es una plataforma educativa que adapta dinámicamente las lecciones de matemáticas para estudiantes de todas las edades.'),
(54, 'Smart Sparrow ofrece herramientas para crear cursos online interactivos que se ajustan a las necesidades individuales de los estudiantes.'),
(55, 'Carnegie Learning combina tecnología de IA con métodos pedagógicos probados para enseñar matemáticas y lenguas.');


--finanzas
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Kensho', 'Análisis financiero avanzado con IA.', 8, 'pago', 'https://www.kensho.com/'),
('AlphaSense', 'Herramienta de búsqueda y análisis financiero.', 8, 'freemium', 'https://www.alpha-sense.com/'),
('Zest AI', 'Evaluación de riesgos crediticios con IA.', 8, 'pago', 'https://www.zest.ai/'),
('Numerai', 'Plataforma de inversión basada en IA.', 8, 'gratis', 'https://numer.ai/'),
('Apex Fintech Solutions', 'Automatización financiera impulsada por IA.', 8, 'freemium', 'https://www.apexfintechsolutions.com/');

INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(56, 'Kensho facilita el análisis de datos financieros complejos mediante IA. Ofrece visualizaciones intuitivas y predicciones precisas.'),
(57, 'AlphaSense optimiza la búsqueda de información en documentos financieros, permitiendo a los analistas tomar decisiones más informadas.'),
(58, 'Zest AI emplea modelos de aprendizaje automático para evaluar riesgos crediticios y mejorar la precisión en los préstamos.'),
(59, 'Numerai es una plataforma de inversión colectiva basada en predicciones de modelos de IA desarrollados por su comunidad.'),
(60, 'Apex Fintech Solutions ofrece herramientas impulsadas por IA para automatizar procesos financieros, desde gestión de carteras hasta análisis de riesgos.');


--marketing-
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Crimson Hexagon', 'Análisis de redes sociales con IA.', 9, 'pago', 'https://www.crimsonhexagon.com/'),
('Phrasee', 'Optimización de campañas de correo electrónico con IA.', 9, 'freemium', 'https://phrasee.co/'),
('Persado', 'Generador de contenido persuasivo basado en IA.', 9, 'pago', 'https://www.persado.com/'),
('Adzooma', 'Gestión automatizada de campañas de marketing.', 9, 'gratis', 'https://www.adzooma.com/'),
('Brandwatch', 'Análisis de marcas y consumidores con IA.', 9, 'freemium', 'https://www.brandwatch.com/');

INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(61, 'Crimson Hexagon utiliza IA para analizar las conversaciones en redes sociales, ayudando a las marcas a entender a sus audiencias.'),
(62, 'Phrasee aplica modelos de IA para optimizar campañas de correo electrónico, asegurando tasas de apertura y conversión más altas.'),
(63, 'Persado genera contenido publicitario altamente persuasivo basado en el análisis del comportamiento del consumidor.'),
(64, 'Adzooma automatiza la gestión de campañas de marketing digital, mejorando el rendimiento y reduciendo el tiempo de configuración.'),
(65, 'Brandwatch combina análisis de datos y visualización para ayudar a las marcas a monitorear su reputación y comprender a sus consumidores.');


-- Soluciones de IA de Texto
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('WriteSonic', 'Herramienta de escritura de contenido optimizada para SEO.', 1, 'freemium', 'https://writesonic.com/'),
('TextOptimizer', 'Optimización de texto para mejorar posicionamiento en motores de búsqueda.', 1, 'pago', 'https://textoptimizer.com/'),
('Copy.ai', 'Asistente de escritura de textos creativos y persuasivos.', 1, 'gratis', 'https://www.copy.ai/'),
('QuillBot', 'Parafraseador y asistente de escritura en múltiples idiomas.', 1, 'freemium', 'https://quillbot.com/'),
('Rytr', 'Generador de contenido asistido por IA.', 1, 'pago', 'https://rytr.me/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(66, 'WriteSonic es ideal para crear contenido enfocado en atraer tráfico orgánico, como artículos, blogs y anuncios.'),
(67, 'TextOptimizer ayuda a optimizar textos con análisis semántico para mejorar el ranking en motores de búsqueda.'),
(68, 'Copy.ai simplifica la creación de copys publicitarios y textos persuasivos para redes sociales y blogs.'),
(69, 'QuillBot reescribe textos para garantizar claridad y precisión, con herramientas adicionales para investigación.'),
(70, 'Rytr permite a los usuarios generar contenido creativo en minutos, adaptándose a diferentes estilos y tonos.');

-- Soluciones de IA de Generación de Imágenes
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('ArtBreeder', 'Creación de arte generativo mediante modificaciones visuales.', 2, 'gratis', 'https://www.artbreeder.com/'),
('DeepAI Image', 'Plataforma para generar imágenes artísticas automáticamente.', 2, 'freemium', 'https://deepai.org/machine-learning-model/art-generator'),
('NightCafe', 'Herramienta para crear arte con estilos personalizados.', 2, 'pago', 'https://creator.nightcafe.studio/'),
('Artisto AI', 'Transformación de fotos en obras de arte con filtros basados en IA.', 2, 'gratis', 'https://artisto.ai/'),
('PaintsChainer', 'Colorea automáticamente dibujos a lápiz con estilos personalizados.', 2, 'freemium', 'https://paintschainer.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(71, 'ArtBreeder permite a los usuarios colaborar en la creación de retratos y paisajes únicos mediante ajustes genéticos.'),
(72, 'DeepAI Image utiliza modelos de aprendizaje profundo para generar obras de arte con solo unos clics.'),
(73, 'NightCafe facilita la creación de arte digital al aplicar estilos artísticos a imágenes existentes o nuevas.'),
(74, 'Artisto AI transforma imágenes y videos en obras de arte inspiradas en estilos de famosos pintores.'),
(75, 'PaintsChainer ofrece coloreado automático de bocetos con resultados altamente personalizables.');

-- Soluciones de IA de Análisis de Datos
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('KNIME Analytics', 'Plataforma de análisis de datos con soporte de IA.', 3, 'gratis', 'https://www.knime.com/'),
('Orange Data Mining', 'Software de minería de datos basado en visualizaciones interactivas.', 3, 'freemium', 'https://orange.biolab.si/'),
('BigML', 'Plataforma para modelos predictivos automatizados.', 3, 'pago', 'https://bigml.com/'),
('AI Sense Analytics', 'Análisis avanzado con aprendizaje automático.', 3, 'freemium', 'https://aisense.com/'),
('Qlik AI', 'Soluciones de inteligencia empresarial con capacidades predictivas.', 3, 'pago', 'https://www.qlik.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(76, 'KNIME Analytics permite a los usuarios integrar y analizar datos con flujos de trabajo visuales.'),
(77, 'Orange Data Mining combina técnicas de minería de datos con visualizaciones que hacen el análisis más intuitivo.'),
(78, 'BigML ofrece modelos predictivos personalizados para una variedad de aplicaciones comerciales y científicas.'),
(79, 'AI Sense Analytics aplica IA para descubrir patrones y tendencias ocultas en grandes conjuntos de datos.'),
(80, 'Qlik AI proporciona análisis detallados y capacidades predictivas para la toma de decisiones informadas.');

-- Soluciones de IA para Matemáticas
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Desmos AI', 'Graficador avanzado con soporte para ecuaciones complejas.', 4, 'gratis', 'https://www.desmos.com/'),
('Microsoft Math Solver', 'Resolución automática de problemas matemáticos.', 4, 'gratis', 'https://math.microsoft.com/'),
('Cymath', 'Asistente matemático para resolver problemas paso a paso.', 4, 'freemium', 'https://www.cymath.com/'),
('Mathpix Snip', 'Conversión de ecuaciones escritas a formato digital.', 4, 'pago', 'https://mathpix.com/'),
('MyScript Calculator', 'Calculadora manual con reconocimiento de escritura.', 4, 'freemium', 'https://www.myscript.com/calculator/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(91, 'Desmos AI ayuda a visualizar funciones y resolver ecuaciones con una interfaz gráfica interactiva.'),
(92, 'Microsoft Math Solver resuelve ecuaciones matemáticas escaneadas o escritas a mano con pasos detallados.'),
(93, 'Cymath proporciona explicaciones claras y detalladas para problemas matemáticos, desde álgebra hasta cálculo.'),
(94, 'Mathpix Snip convierte ecuaciones escritas a mano en texto LaTeX o imágenes listas para documentos.'),
(95, 'MyScript Calculator permite resolver problemas matemáticos escribiendo a mano en la pantalla.');

-- Soluciones de IA de Texto
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('ContentBot', 'Generador de contenido para blogs, redes sociales y marketing.', 1, 'pago', 'https://www.contentbot.ai/'),
('Frase.io', 'Herramienta de optimización de contenido y creación rápida de resúmenes.', 1, 'freemium', 'https://www.frase.io/'),
('Ink Editor', 'Editor inteligente para escribir contenido optimizado.', 1, 'pago', 'https://inkforall.com/'),
('HyperWrite', 'Asistente de escritura que aprende del usuario para mejorar sugerencias.', 1, 'freemium', 'https://www.hyperwriteai.com/'),
('TextCortex', 'Herramienta para generación rápida de texto creativo.', 1, 'pago', 'https://textcortex.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(96, 'ContentBot es ideal para creadores de contenido que necesitan producir textos eficaces para estrategias digitales.'),
(97, 'Frase.io permite identificar y cubrir brechas de contenido mediante análisis de temas populares.'),
(98, 'Ink Editor combina inteligencia artificial con herramientas de SEO para maximizar el impacto del contenido.'),
(99, 'HyperWrite mejora la experiencia de escritura al aprender preferencias y estilos específicos del usuario.'),
(100, 'TextCortex genera textos creativos y coherentes, perfectos para proyectos de escritura rápida.');

-- Soluciones de IA de Generación de Imágenes
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('RunwayML', 'Generador de imágenes y videos con soporte para edición avanzada.', 2, 'freemium', 'https://runwayml.com/'),
('Deep Dream Generator', 'Crea imágenes artísticas utilizando redes neuronales.', 2, 'pago', 'https://deepdreamgenerator.com/'),
('Daz 3D', 'Herramienta para creación de gráficos 3D hiperrealistas.', 2, 'pago', 'https://www.daz3d.com/'),
('GANPaint Studio', 'Edición inteligente de imágenes utilizando redes GAN.', 2, 'gratis', 'https://ganpaint.io/'),
('Pix2Pix', 'Transforma bocetos simples en imágenes realistas.', 2, 'gratis', 'https://affinelayer.com/pixsrv/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(101, 'RunwayML combina creatividad con modelos avanzados para generar imágenes y videos de alta calidad.'),
(102, 'Deep Dream Generator utiliza redes neuronales para crear interpretaciones artísticas únicas de fotos e imágenes.'),
(103, 'Daz 3D permite diseñar y renderizar figuras humanas y escenarios realistas para proyectos gráficos.'),
(104, 'GANPaint Studio facilita la edición de imágenes añadiendo o eliminando elementos de manera natural.'),
(105, 'Pix2Pix convierte bocetos básicos en imágenes fotorrealistas, ideal para prototipos visuales.');

-- Soluciones de IA de Marketing
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('HubSpot', 'Plataforma de marketing todo-en-uno para automatización y análisis.', 5, 'freemium', 'https://www.hubspot.com/'),
('Mailchimp', 'Herramienta de marketing por correo electrónico y automatización para empresas.', 5, 'freemium', 'https://mailchimp.com/'),
('Copy.ai', 'Generador de textos publicitarios para anuncios y contenido en redes sociales.', 5, 'pago', 'https://www.copy.ai/'),
('Scalenut', 'Plataforma de contenido y SEO impulsada por IA para marcas y empresas.', 5, 'freemium', 'https://www.scalenut.com/'),
('Semrush', 'Herramienta de marketing digital para mejorar el SEO y la visibilidad online.', 5, 'pago', 'https://www.semrush.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(106, 'HubSpot ofrece soluciones integradas de marketing y ventas, optimizando las interacciones con los clientes.'),
(107, 'Mailchimp es una herramienta esencial para campañas de email marketing, facilitando la automatización.'),
(108, 'Copy.ai permite a los usuarios crear contenido de marketing altamente persuasivo y personalizado.'),
(109, 'Scalenut ayuda a las empresas a crear contenido relevante mientras optimiza los motores de búsqueda.'),
(110, 'Semrush es una plataforma integral para mejorar el SEO, análisis de competidores y más estrategias de marketing digital.');

-- Soluciones de IA en Reconocimiento de Voz
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Google Speech-to-Text', 'Servicio de transcripción y reconocimiento de voz a texto en tiempo real.', 6, 'pago', 'https://cloud.google.com/speech-to-text'),
('Amazon Transcribe', 'API que convierte grabaciones de audio a texto, ideal para empresas.', 6, 'pago', 'https://aws.amazon.com/transcribe/'),
('Microsoft Azure Speech', 'Plataforma que proporciona servicios de reconocimiento de voz y texto desde audio.', 6, 'pago', 'https://azure.microsoft.com/en-us/services/cognitive-services/speech-to-text/'),
('Speechmatics', 'Plataforma avanzada de transcripción de voz que soporta múltiples idiomas y acentos.', 6, 'pago', 'https://www.speechmatics.com/'),
('Rev.ai', 'API de reconocimiento de voz para transcripción automática de grabaciones de audio y video.', 6, 'pago', 'https://www.rev.ai/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(111, 'Google Speech-to-Text convierte audio en texto de manera precisa y en tiempo real, ideal para transcripciones automáticas.'),
(112, 'Amazon Transcribe transcribe grabaciones de audio, ideal para clientes en sectores como el de atención al cliente o medicina.'),
(113, 'Microsoft Azure Speech permite transformar voz en texto y agregarle análisis de sentimientos o tonos.'),
(114, 'Speechmatics ofrece transcripción de voz a texto utilizando IA avanzada para soportar múltiples idiomas y contextos.'),
(115, 'Rev.ai proporciona una API fácil de usar para integrar reconocimiento de voz en aplicaciones, mejorando la accesibilidad.');

-- Soluciones de IA en Educación
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Socratic', 'Aplicación educativa que utiliza IA para ayudar a los estudiantes a resolver problemas matemáticos y científicos.', 7, 'gratis', 'https://socratic.org/'),
('Knewton', 'Plataforma adaptativa de aprendizaje que utiliza IA para personalizar el contenido educativo.', 7, 'pago', 'https://www.knewton.com/'),
('Duolingo', 'App de aprendizaje de idiomas que utiliza IA para personalizar lecciones según el progreso del usuario.', 7, 'freemium', 'https://www.duolingo.com/'),
('Quizlet', 'Herramienta de aprendizaje basada en IA para crear tarjetas didácticas y practicar conceptos.', 7, 'freemium', 'https://quizlet.com/'),
('Edmodo', 'Plataforma educativa que incorpora IA para mejorar la experiencia de aprendizaje en línea y colaboración entre estudiantes.', 7, 'gratis', 'https://www.edmodo.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(116, 'Socratic usa IA para ayudar a los estudiantes a resolver problemas complejos en matemáticas y ciencias, proporcionando explicaciones claras.'),
(117, 'Knewton utiliza algoritmos de aprendizaje adaptativo para personalizar el material educativo según las necesidades de los estudiantes.'),
(118, 'Duolingo utiliza IA para ajustar las lecciones de idiomas, adaptándose al nivel de habilidad y ritmo de aprendizaje del usuario.'),
(119, 'Quizlet permite a los estudiantes crear tarjetas de estudio personalizadas y usar IA para obtener recomendaciones de aprendizaje más efectivas.'),
(120, 'Edmodo facilita la enseñanza en línea mediante IA que personaliza el contenido, promoviendo una experiencia educativa eficiente.');

-- Soluciones de IA en Finanzas
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Kensho', 'Plataforma financiera que utiliza IA para análisis predictivos y asesoría financiera en tiempo real.', 8, 'pago', 'https://www.kensho.com/'),
('Zest AI', 'IA para evaluar riesgos crediticios y automatizar la toma de decisiones financieras.', 8, 'pago', 'https://www.zest.ai/'),
('Upstart', 'Plataforma que utiliza IA para ofrecer préstamos personales basados en el análisis de datos alternativos.', 8, 'pago', 'https://www.upstart.com/'),
('Ant Financial', 'Soluciones financieras basadas en IA para optimizar pagos, créditos y seguros.', 8, 'pago', 'https://www.antgroup.com/'),
('AlphaSense', 'Herramienta de análisis de datos financieros usando IA para detectar tendencias y oportunidades de inversión.', 8, 'pago', 'https://www.alpha-sense.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(121, 'Kensho proporciona herramientas avanzadas para análisis predictivos y asesoría financiera basada en IA, mejorando la toma de decisiones.'),
(122, 'Zest AI utiliza modelos de aprendizaje automático para ofrecer decisiones crediticias más precisas y personalizadas.'),
(123, 'Upstart utiliza IA para evaluar el crédito de los solicitantes, basándose en factores alternativos como la educación y el empleo.'),
(124, 'Ant Financial mejora la eficiencia y seguridad en pagos, préstamos y seguros utilizando inteligencia artificial avanzada.'),
(125, 'AlphaSense ofrece inteligencia financiera que utiliza IA para ayudar a las empresas a detectar oportunidades de inversión.');

-- Soluciones de IA en Marketing
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('HubSpot AI', 'Plataforma de marketing todo-en-uno que usa IA para automatizar el marketing digital.', 9, 'pago', 'https://www.hubspot.com/'),
('Marketo', 'Herramienta de automatización de marketing que usa IA para personalizar campañas y mejorar la conversión de leads.', 9, 'pago', 'https://www.marketo.com/'),
('Hootsuite Insights', 'Plataforma que utiliza IA para el análisis de redes sociales y obtener insights de campañas en tiempo real.', 9, 'pago', 'https://hootsuite.com/products/insights'),
('CleverTap', 'Plataforma de marketing inteligente que utiliza IA para optimizar la retención de clientes y mejorar el compromiso.', 9, 'freemium', 'https://www.clevertap.com/'),
('Phrasee', 'Generador de contenido de marketing basado en IA para optimizar títulos y correos electrónicos de manera automática.', 9, 'pago', 'https://www.phrasee.co/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(126, 'HubSpot AI permite crear campañas automatizadas y personalizadas para mejorar la captación y conversión de clientes.'),
(127, 'Marketo utiliza IA para crear campañas altamente personalizadas, mejorando la relevancia y el rendimiento de las estrategias de marketing.'),
(128, 'Hootsuite Insights permite analizar grandes volúmenes de datos de redes sociales y obtener informes detallados para tomar decisiones de marketing.'),
(129, 'CleverTap utiliza IA para personalizar las campañas de marketing y retener usuarios con ofertas personalizadas y mensajes optimizados.'),
(130, 'Phrasee usa IA para generar contenido atractivo para campañas de marketing, optimizando el rendimiento de los correos electrónicos y publicaciones.');

-- Soluciones de IA en Videojuegos
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Unity ML-Agents', 'Herramienta que permite entrenar agentes dentro de juegos para mejorar su comportamiento.', 5, 'gratis', 'https://unity.com/es/products/machine-learning-agents'),
('DeepMind Lab', 'Plataforma de inteligencia artificial para experimentar en entornos de videojuegos complejos.', 5, 'gratis', 'https://deepmind.com/research/dm-lab'),
('OpenAI Five', 'Sistema de IA que juega Dota 2 a nivel profesional, demostrado por OpenAI.', 5, 'gratis', 'https://openai.com/research/openai-five'),
('AI Dungeon', 'Juego interactivo basado en texto que utiliza IA para generar historias personalizadas.', 5, 'freemium', 'https://play.aidungeon.io/'),
('Botlane', 'Herramienta para crear bots que pueden ser entrenados para jugar videojuegos de estrategia.', 5, 'pago', 'https://www.botlane.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(131, 'Unity ML-Agents permite a los desarrolladores entrenar agentes inteligentes para simular comportamientos y decisiones dentro de videojuegos.'),
(132, 'DeepMind Lab es un entorno de simulación avanzado que usa IA para estudiar y resolver problemas complejos en videojuegos.'),
(133, 'OpenAI Five revolucionó el ámbito de los eSports al demostrar que un sistema de IA puede jugar a nivel profesional.'),
(134, 'AI Dungeon genera aventuras y narrativas personalizadas usando IA para crear experiencias de juego interactivas.'),
(135, 'Botlane permite a los usuarios entrenar bots para juegos de estrategia en línea, personalizando sus tácticas y comportamientos.');

-- Soluciones de IA en Texto
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('GPT-3', 'Modelo de lenguaje avanzado capaz de generar texto coherente y natural a partir de indicaciones.', 1, 'pago', 'https://openai.com/'),
('QuillBot', 'Herramienta de reescritura de textos que usa IA para mejorar la claridad y estilo de los contenidos.', 1, 'freemium', 'https://quillbot.com/'),
('Grammarly', 'Asistente de escritura que utiliza IA para corregir gramática, ortografía y mejorar la redacción de textos.', 1, 'freemium', 'https://www.grammarly.com/'),
('Hemingway Editor', 'Editor de texto con IA que ayuda a mejorar la legibilidad y estilo de escritura.', 1, 'pago', 'http://www.hemingwayapp.com/'),
('Wordtune', 'Herramienta de escritura inteligente que ayuda a reformular y mejorar la calidad de los textos mediante IA.', 1, 'freemium', 'https://www.wordtune.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(136, 'GPT-3 es un modelo de lenguaje generativo que produce texto natural y coherente a partir de cualquier solicitud, ideal para aplicaciones de chatbots, redacción automática, y más.'),
(137, 'QuillBot utiliza IA para reescribir textos de manera que se mantenga el significado, pero mejorando la claridad, estilo y concisión.'),
(138, 'Grammarly ayuda a los usuarios a escribir de manera más efectiva al corregir errores gramaticales y mejorar la estructura de las oraciones.'),
(139, 'Hemingway Editor utiliza IA para analizar y mejorar la legibilidad del texto, recomendando cambios que simplifican la escritura.'),
(140, 'Wordtune es una herramienta que usa IA para sugerir mejoras en el estilo, tono y claridad de los textos, adaptándose al contexto y al público objetivo.');

-- Soluciones de IA en Generación de Imágenes
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('DALL-E 2', 'Generador de imágenes a partir de descripciones textuales, utilizando IA para crear imágenes realistas o artísticas.', 2, 'pago', 'https://openai.com/dall-e-2'),
('DeepArt', 'Plataforma que convierte fotos en obras de arte utilizando redes neuronales y técnicas de IA.', 2, 'pago', 'https://deepart.io/'),
('Artbreeder', 'Generador de imágenes basado en IA que permite crear y modificar arte mediante la combinación de imágenes existentes.', 2, 'freemium', 'https://www.artbreeder.com/'),
('RunwayML', 'Herramienta de IA para crear y manipular imágenes, videos y sonidos, utilizada en la industria creativa.', 2, 'pago', 'https://runwayml.com/'),
('NightCafe', 'Generador de arte basado en IA que permite crear obras visuales a partir de simples descripciones textuales.', 2, 'freemium', 'https://creator.nightcafe.studio/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(141, 'DALL-E 2 de OpenAI es capaz de crear imágenes de alta calidad a partir de descripciones textuales, explorando conceptos visuales innovadores.'),
(142, 'DeepArt convierte tus fotos en pinturas utilizando IA, emulando los estilos de artistas famosos con resultados visuales impresionantes.'),
(143, 'Artbreeder utiliza IA para combinar y modificar imágenes, permitiendo a los usuarios crear nuevas obras de arte de forma sencilla.'),
(144, 'RunwayML es una plataforma creativa que usa IA para generar y manipular imágenes y videos, ideal para profesionales de la creatividad.'),
(145, 'NightCafe convierte textos simples en impresionantes obras de arte generadas por IA, ofreciendo diferentes estilos artísticos.');

-- Soluciones de IA en Análisis de Datos
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Tableau', 'Plataforma de análisis de datos que utiliza IA para generar visualizaciones interactivas y realizar predicciones.', 3, 'pago', 'https://www.tableau.com/'),
('Power BI', 'Herramienta de Microsoft que usa IA para transformar datos en informes y gráficos interactivos de fácil comprensión.', 3, 'pago', 'https://powerbi.microsoft.com/'),
('DataRobot', 'Plataforma que automatiza el análisis de datos utilizando IA, proporcionando modelos predictivos a partir de datos históricos.', 3, 'pago', 'https://www.datarobot.com/'),
('RapidMiner', 'Plataforma de minería de datos que utiliza IA para procesar grandes volúmenes de datos y extraer información relevante.', 3, 'freemium', 'https://rapidminer.com/'),
('SAS Viya', 'Plataforma de análisis y visualización de datos que integra IA para mejorar la toma de decisiones empresariales.', 3, 'pago', 'https://www.sas.com/en_us/software/viya.html');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(146, 'Tableau permite transformar datos complejos en visualizaciones interactivas, usando IA para ayudar en la toma de decisiones más informadas.'),
(147, 'Power BI facilita la creación de dashboards y gráficos interactivos, permitiendo análisis profundos con la ayuda de IA para descubrir patrones y tendencias.'),
(148, 'DataRobot utiliza IA para crear modelos predictivos a partir de grandes volúmenes de datos, facilitando la toma de decisiones basada en datos.'),
(149, 'RapidMiner permite realizar análisis avanzados sobre grandes conjuntos de datos, utilizando IA para identificar patrones y hacer predicciones precisas.'),
(150, 'SAS Viya integra IA para procesar datos en tiempo real, proporcionando soluciones analíticas y predictivas para mejorar el rendimiento empresarial.');

-- Soluciones de IA en Matemáticas
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Wolfram Alpha', 'Motor computacional de conocimientos que utiliza IA para resolver problemas matemáticos y científicos.', 4, 'freemium', 'https://www.wolframalpha.com/'),
('Mathematica', 'Plataforma de Wolfram que utiliza IA para realizar cálculos matemáticos complejos y visualizar soluciones.', 4, 'pago', 'https://www.wolfram.com/mathematica/'),
('SymPy', 'Biblioteca de Python que usa IA para manipular y resolver expresiones matemáticas de manera simbólica.', 4, 'gratis', 'https://www.sympy.org/'),
('Maxima', 'Sistema de álgebra computacional que utiliza IA para realizar operaciones matemáticas complejas y simplificar ecuaciones.', 4, 'gratis', 'http://maxima.sourceforge.net/'),
('GeoGebra', 'Aplicación matemática que utiliza IA para crear gráficos interactivos y resolver ecuaciones.', 4, 'gratis', 'https://www.geogebra.org/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(151, 'Wolfram Alpha utiliza IA para procesar y responder preguntas matemáticas y científicas, generando soluciones completas y detalladas.'),
(152, 'Mathematica es una plataforma avanzada de Wolfram que emplea IA para realizar cálculos complejos, visualizaciones y análisis matemáticos.'),
(153, 'SymPy es una biblioteca de Python que usa IA para resolver problemas matemáticos simbólicos, como integrales, derivadas, ecuaciones algebraicas, entre otros.'),
(154, 'Maxima es un sistema de álgebra computacional de código abierto que utiliza IA para simplificar y resolver ecuaciones matemáticas complejas.'),
(155, 'GeoGebra permite crear representaciones visuales de ecuaciones matemáticas y explorar conceptos de álgebra, geometría y cálculo mediante IA.');

-- Soluciones de IA en Videojuegos
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Unity ML-Agents', 'Plataforma que permite crear y entrenar agentes inteligentes en videojuegos utilizando IA para mejorar su comportamiento.', 5, 'gratis', 'https://unity.com/es/products/machine-learning-agents'),
('OpenAI Five', 'Sistema de IA desarrollado para jugar Dota 2, demostrando la capacidad de los algoritmos para competir a nivel profesional.', 5, 'gratis', 'https://openai.com/research/openai-five'),
('Botlane', 'Plataforma de IA que permite crear bots que aprenden a jugar videojuegos de estrategia, mejorando continuamente.', 5, 'pago', 'https://www.botlane.com/'),
('DeepMind Lab', 'Herramienta de simulación que utiliza IA para experimentar con entornos y aprender comportamientos en videojuegos.', 5, 'gratis', 'https://deepmind.com/research/'),
('AI Dungeon', 'Videojuego interactivo que utiliza IA para generar historias y decisiones dentro de un juego de aventura.', 5, 'freemium', 'https://play.aidungeon.io/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(156, 'Unity ML-Agents permite crear agentes inteligentes que pueden aprender a jugar videojuegos en entornos controlados, mejorando el comportamiento de los personajes.'),
(157, 'OpenAI Five demostró el potencial de la IA para competir al más alto nivel en videojuegos, ganando a equipos profesionales de Dota 2.'),
(158, 'Botlane crea bots que mejoran continuamente su habilidad para jugar videojuegos de estrategia mediante el uso de IA, optimizando su rendimiento.'),
(159, 'DeepMind Lab es un entorno de simulación para la IA que permite experimentar con diferentes tipos de juegos y entornos, aprendiendo a adaptarse y mejorar.'),
(160, 'AI Dungeon utiliza IA para generar historias interactivas, permitiendo a los jugadores tomar decisiones y vivir aventuras personalizadas dentro del juego.');

-- Soluciones de IA en Reconocimiento de Voz
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Sonix', 'Sonix es un servicio de transcripción automática que convierte el habla en texto utilizando IA avanzada para obtener transcripciones rápidas y precisas.', 6, 'pago', 'https://sonix.ai/'),
('Trint', 'Trint es una plataforma que utiliza IA para convertir audio y video en texto, proporcionando herramientas para editar y exportar las transcripciones.', 6, 'pago', 'https://www.trint.com/'),
('Verbit', 'Plataforma de transcripción y subtitulado que emplea IA para generar transcripciones en tiempo real con una alta precisión en diversas industrias.', 6, 'pago', 'https://www.verbit.ai/'),
('Deepgram', 'Deepgram ofrece un servicio de reconocimiento de voz personalizado utilizando IA para analizar conversaciones y proporcionar resultados precisos en tiempo real.', 6, 'pago', 'https://www.deepgram.com/'),
('VoiceBase', 'VoiceBase utiliza IA para analizar y transcribir grabaciones de voz, mejorando la accesibilidad y la comprensión del contenido hablado.', 6, 'pago', 'https://www.voicebase.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(161, 'Sonix ofrece un sistema avanzado de transcripción que utiliza IA para garantizar una alta precisión, soportando diferentes idiomas y acentos.'),
(162, 'Trint convierte el contenido de video y audio en texto utilizando IA, permitiendo editar las transcripciones en línea y exportarlas en diferentes formatos.'),
(163, 'Verbit es una solución de transcripción y subtitulado que utiliza IA y un equipo humano para mejorar la precisión de las transcripciones, especialmente útil en entornos educativos y empresariales.'),
(164, 'Deepgram emplea IA para personalizar el reconocimiento de voz, permitiendo a las empresas transcribir y analizar grandes volúmenes de conversaciones de manera eficiente.'),
(165, 'VoiceBase usa inteligencia artificial para analizar grabaciones de voz y generar transcripciones precisas, aplicables en sectores como el de la atención al cliente y la educación.');

-- Soluciones de IA en Educación
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Squirrel AI', 'Squirrel AI es una plataforma educativa que utiliza IA para crear rutas de aprendizaje personalizadas y adaptativas, mejorando la experiencia educativa.', 7, 'pago', 'https://www.squirrelai.com/'),
('MATHia', 'MATHia es una plataforma educativa que utiliza IA para proporcionar tutoría personalizada en matemáticas, adaptándose al ritmo y las necesidades del estudiante.', 7, 'pago', 'https://www.carnegielearning.com/'),
('Otus', 'Otus es una plataforma de gestión del aprendizaje que utiliza IA para monitorear el progreso de los estudiantes y mejorar las estrategias pedagógicas en tiempo real.', 7, 'pago', 'https://www.otus.com/'),
('Ada', 'Ada es una plataforma educativa que utiliza IA para crear un ambiente de aprendizaje interactivo, proporcionando asistencia personalizada en tiempo real a los estudiantes.', 7, 'pago', 'https://www.ada.support/'),
('Brainly', 'Brainly es una plataforma educativa que utiliza IA para proporcionar respuestas personalizadas a las preguntas de los estudiantes, conectándolos con una comunidad de aprendizaje.', 7, 'freemium', 'https://brainly.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(166, 'Squirrel AI ofrece una experiencia de aprendizaje adaptativa, utilizando IA para personalizar las rutas de estudio en función de las habilidades y progresos individuales de los estudiantes.'),
(167, 'MATHia utiliza IA para enseñar matemáticas de manera personalizada, proporcionando un entorno de tutoría adaptativa que ajusta las lecciones según el rendimiento del estudiante.'),
(168, 'Otus emplea IA para analizar el progreso de los estudiantes y ofrece recomendaciones de enseñanza personalizadas, facilitando a los educadores la mejora continua del aprendizaje.'),
(169, 'Ada utiliza IA para ofrecer respuestas personalizadas y asistencia en tiempo real, creando una experiencia educativa interactiva y única para cada estudiante.'),
(170, 'Brainly utiliza IA para proporcionar soluciones educativas personalizadas, conectando a los estudiantes con expertos y otros estudiantes en tiempo real para resolver dudas y aprender de manera colaborativa.');

-- Soluciones de IA en Finanzas
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Clearscore', 'Clearscore es una plataforma que utiliza IA para ayudar a los usuarios a gestionar su puntaje crediticio y obtener recomendaciones financieras personalizadas.', 8, 'gratis', 'https://www.clearscore.com/'),
('Tally', 'Tally es una aplicación financiera que utiliza IA para ayudar a los usuarios a gestionar sus deudas y optimizar sus pagos mensuales.', 8, 'freemium', 'https://www.meettally.com/'),
('Personal Capital', 'Personal Capital emplea IA para ofrecer recomendaciones personalizadas sobre la gestión de dinero y la inversión, proporcionando una visión integral de las finanzas personales.', 8, 'gratis', 'https://www.personalcapital.com/'),
('LenddoEFL', 'LenddoEFL utiliza IA para evaluar la solvencia crediticia a través de datos no tradicionales, mejorando el acceso a servicios financieros en mercados emergentes.', 8, 'pago', 'https://www.lenddoefl.com/'),
('Sigma Computing', 'Sigma Computing usa IA para realizar análisis de datos financieros en tiempo real, ayudando a las empresas a tomar decisiones más informadas.', 8, 'pago', 'https://www.sigmacomputing.com/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(171, 'Clearscore usa IA para ayudar a los usuarios a entender y mejorar su puntaje crediticio, ofreciendo herramientas personalizadas que permiten tomar decisiones financieras informadas.'),
(172, 'Tally ayuda a los usuarios a gestionar su deuda utilizando IA para calcular los pagos mensuales óptimos y las estrategias para reducir la deuda de manera eficiente.'),
(173, 'Personal Capital utiliza IA para brindar a los usuarios asesoramiento financiero integral, ayudándoles a tomar decisiones informadas sobre sus ahorros, inversiones y planificación para la jubilación.'),
(174, 'LenddoEFL aplica IA para evaluar el crédito a través de datos alternativos como redes sociales y comportamiento en línea, facilitando el acceso al crédito en regiones con baja bancarización.'),
(175, 'Sigma Computing utiliza IA para ofrecer herramientas de análisis financiero en tiempo real, permitiendo a las empresas tomar decisiones más ágiles y fundamentadas mediante la visualización de datos.');

-- Soluciones de IA en Marketing
INSERT INTO solucion_ia (nombre, descripcion, categoria_id, precio, enlace) VALUES
('Persado', 'Persado es una plataforma de marketing que utiliza IA para generar mensajes de marketing efectivos que aumentan la tasa de conversión de las campañas.', 9, 'pago', 'https://www.persado.com/'),
('Acquisio', 'Acquisio utiliza IA para automatizar la gestión de campañas publicitarias, optimizando el gasto en publicidad y mejorando el retorno de inversión.', 9, 'pago', 'https://www.acquisio.com/'),
('Crimson Hexagon', 'Crimson Hexagon utiliza IA para analizar redes sociales y datos de mercado, proporcionando información valiosa sobre la opinión del consumidor y el comportamiento del mercado.', 9, 'pago', 'https://www.crimsonhexagon.com/'),
('Drift', 'Drift es una plataforma de marketing conversacional que usa IA para mejorar la comunicación con los clientes a través de chatbots inteligentes en tiempo real.', 9, 'pago', 'https://www.drift.com/'),
('Albert', 'Albert es una plataforma de automatización de marketing que emplea IA para ejecutar y optimizar campañas de marketing digital de manera autónoma.', 9, 'pago', 'https://www.albert.ai/');

-- Descripciones Ampliadas
INSERT INTO descripcion_ampliada (solucion_id, descripcion_ampliada) VALUES
(176, 'Persado usa IA para analizar datos de marketing y generar mensajes personalizados que aumentan el rendimiento de las campañas publicitarias, mejorando la interacción con los clientes.'),
(177, 'Acquisio aplica IA para gestionar y optimizar el rendimiento de las campañas de publicidad digital, maximizando el retorno de inversión mediante la automatización del proceso.'),
(178, 'Crimson Hexagon utiliza IA para recopilar y analizar grandes cantidades de datos de redes sociales, ayudando a las marcas a entender mejor las tendencias de los consumidores y mejorar sus estrategias.'),
(179, 'Drift utiliza IA en sus chatbots para interactuar con los clientes en tiempo real, proporcionando respuestas personalizadas y mejorando la experiencia del cliente en las campañas de marketing.'),
(180, 'Albert es una plataforma autónoma que emplea IA para gestionar y optimizar campañas de marketing digital, realizando ajustes automáticamente para mejorar los resultados en tiempo real.');




-- En tabla solucion_ia
DELETE FROM solucion_ia WHERE id IN (106, 92, 93, 94, 95);
UPDATE solucion:ia where id in
-- En tabla descripcion_ampliada
DELETE FROM descripcion_ampliada WHERE solucion_id IN (91, 92, 93, 94, 95);


DELETE FROM descripcion_ampliada WHERE solucion_id = 160;
DELETE FROM solucion_ia WHERE id = 160;
-- Verifica si el registro con id = 81 existe en solucion_ia
SELECT * FROM solucion_ia;

UPDATE solucion_ia
SET categoria_id = 9
WHERE categoria_id = 5
AND nombre IN ('HubSpot', 'Mailchimp', 'Copy.ai', 'Scalenut', 'Semrush');

