#import ("/src/titul.typ"): *
#import ("/src/preamble.typ"): *
#show: main
#titul(
  Институт: [Информационных Технологий],
  Кафедра: [Вычислительной Техники],
  Практика: [Практическая работа №1\
            "Онтология"],
  Дисциплина: ["Системный анализ данных СППР"],
  Группа: [ИКБО-04-22],
  Студент: [Егоров Л.А.],
  Преподаватель: [Железняк Л.М.]
)
#show: template

#outline()


//
// ВВЕДЕНИЕ
// 

#let intro = [
Возникновение онтологий и их стремительное развитие связано с проявлением в нашей реальности следующих новых факторов: 
- колоссальный рост объемов информации, предъявляемых для обработки (анализа, использования) специалистам самых различных областей деятельности
- чрезвычайная зашумленность этих потоков (повторы, противоречивость, разноуровневость, и т.п.)
- острая необходимость в использовании одних и тех же знаний разными специалистами в разных целях
- всеобщая интернетизация нашей жизни и острая необходимость в структуризации информации для её представления пользователям и более эффективного поиска
- необходимость сокращения времени на поиск нужной информации и повышения качества информационных услуг в Интернете

Онтологии –-- это базы знаний специального типа, которые могут читаться и пониматься, отчуждаться от разработчика и/или физически разделяться их пользователями.

Существует много видов онтологий, однако одним из самых широко применяемых видов являются онтологии предметных областей, содержащие понятия определённой области знаний или входящих в неё областей.
Формальная модель онтологии представлена следующей формулой:
#eq-simple($ O = < X, R, F> " ,"$)

#print_symbols(
[$X$ --- конечное множество концептов (понятий, терминов) предметной области, которую представляет онтология],
[$R$ --- конечное множество отношений между концептами (понятиями, терминами) заданной предметной области],
[$F$ --- конечное множество функций интерпретации (аксиоматизации), заданных на концептах и/или отношениях онтологии]
)

Существует много видов онтологий, однако одним из самых широко применяемых видов являются онтологии предметных областей, содержащие понятия определённой области знаний или входящих в неё областей.
]

//
// ОСНОВНАЯ ЧАСТЬ
// 

#let main = [
== Постановка задачи
Необходимо разработать онтологию выбранной предметной области --- "Музыкальная индустрия". Данная предметная область выбрана в связи с тем, что в современном мире прослушивание музыки стало очень доступным с использованием стриминговых сервисов, и поэтому есть острая необходимость в систематизации музыки, чтобы её было доступно выкладывать в Интернет @Sorokin.
== Описание онтологии
Основным продуктом звукозаписывающих компаний являются музыкальные записи --- наиболее распространёнными из них являются песни и альбомы, являющиеся сборниками песен. Авторами альбомов выступают либо группы, либо отдельные музыканты, и обе эти категории также связаны между собой –-- группы состоят из музыкантов @Karpenko.

На основе этого описания можно составить онтологию, состоящую из следующих классов:
- "Музыкальная индустрия" — общий базовый класс для всех классов
- "Музыкальная запись" — базовый класс для разных видов музыкальных записей, содержит общий слот "Название"
- "Альбом" — класс для описания альбомов, содержит слоты "Год выхода" и "Исполнитель", ссылающийся на экземпляр класса "Исполнитель"
- "Песня" — класс для описания песен, содержит слот "Входит в альбом", ссылающийся на экземпляр класса "Альбом"
- "Исполнитель" — базовый класс для всех видов исполнителей, содержит общие слоты "Имя" и "Страна происхождения"
- "Группа" — класс для описания групп, не содержит своих слотов
- "Музыкант" — класс для описания музыкантов, содержит слот "Входит в группу", ссылающийся на экземпляр класса "Группа"
Данное описание использовано для построения графической схемы онтологии (Рисунок @ont-schema).
#figure(image("/img/main1_ont_schema.png"), caption: [Схема онтологии "Музыкальная индустрия"])<ont-schema>

== Построение онтологии в Protégé
Для подробного изучения составленной онтологии использован инструмент для построения, редактирования онтологий и работы с ними Protégé. Сначала созданы классы, представленные на Рисунке @class-hier.

#figure(image("/img/main1_class.png"), caption: [Составленная иерархия классов])<class-hier>

На Рисунке @album-class представлены слоты класса "Альбом". Слотами данного класса являются: название альбома, исполнитель и год выпуска.

#figure(image("/img/main1_album.png"), caption: [Слоты класса "Альбом"])<album-class>

На Рисунке @song-class представлены слоты класса "Песня". Слотами данного класса являются: альбом и название.

#figure(image("/img/main1_song.png"), caption: [Слоты класса "Песня"])<song-class>

На Рисунке @musician-class представлены слоты класса "Музыкант". Слотами данного класса являются: страна происхождения, группа и имя.

#figure(image("/img/main1_musician.png"), caption: [Cлоты класса "Музыкант"])<musician-class>

На Рисунке @group-class представлены слоты класса "Группа". Слотами данного класса являются страна и название.

#figure(image("/img/main1_group.png"), caption: [Слоты класса "Группа"])<group-class>

После составления и описания классов созданы экземпляры каждого из классов. На Рисунке @group-ex представлены экземпляры класса "Группа" и значения полей в одном из них.

#figure(image("/img/main1_group_ex.png"), caption: [Экземпляры класса "Группа"])<group-ex>

На Рисунке @musician-ex представлены экземпляры класса "Музыкант" и значения полей в одном из них.
 
#figure(image("/img/main1_musician_ex.png"), caption: [Экземпляры класса "Музыкант"])<musician-ex>

На Рисунке @song-ex представлены экземпляры класса "Песня" и значения полей в одном из них.
 
#figure(image("/img/main1_song-ex.png"), caption: [Экземпляры класса "Песня"])<song-ex>

На Рисунке @album-ex представлены экземпляры класса "Альбом" и значения полей в одном из них.
 
#figure(image("/img/main1_album-ex.png"), caption: [Экземпляры класса "Альбом"])<album-ex>

== Выполнение запросов в Protege
Программа Protégé позволяет составлять запросы на получение объектов по определённым условиям, а также вытаскивать связанные объекты для уже полученных объектов. Проделан обычный запрос на получение экземпляров (Рисунок @simple).

#figure(image("/img/main1_simple.png"), caption: [Одинарный запрос на получение песен из альбома])<simple>
 
На Рисунке @chained представлен цепной запрос на получение песен, написанных одной группой.

#figure(image("/img/main1_chained.png", height: 20%), caption: [Цепной запрос на получение песен, написанных одной группой])<chained>

На Рисунке @chained1 представлен цепной запрос на получение песен, написанных одним музыкантом.

#figure(image("/img/main1_chained1.png"), caption: [Цепной запрос на получение песен, написанных одним музыкантом])<chained1>
 
== Результаты выполнения программного кода
Для работы с онтологиями написана программа на языке Python, которая запускается в консоли и поддерживает выполнение запросов на получение экземпляров. Её код представлен в Листинге @ont. На Рисунке @ont-result1 представлен результат выполнения запроса музыкантов в группе, выполненный в программе.

#figure(image("/img/main1_result1.png"), caption: [Результат выполнения программы])<ont-result1>

На Рисунке @ont-result2 представлен результат получения песен, написанных группой, с помощью запроса, выполненного в программе.

#figure(image("/img/main1_result2.png"), caption: [Результат выполнения программы])<ont-result2>
]

//
// ЗАКЛЮЧЕНИЕ
// 

#let outro = [
В ходе выполнения данной практической работы изучены теоретические основы системного анализа и использования онтологий в широком ряде задач, получены навыки построения онтологий и работы с ними, включая создание классов для описания выбранной предметной области, создание слотов в классах и создание экземпляров. С помощью инструменты работы с онтологиями Protégé выполнены запросы на получение объектов по различным запросам.

В качестве закрепления полученных знаний написана программа на языке Python, способная работать с онтологией выбранной предметной области. В её функционал входит возможность писать запросы на получение экземпляров и связанных объектов.
]

//
// ПРИЛОЖЕНИЯ
// 

#let app = [
==== Код реализации онтологии на языке Python

#simple-code(raw(read("/include/prac1.py")),
             "Код файла main.py",
             label: <ont>)
]

#heading("Введение", numbering: none)
#intro

= Онтология
#main

#heading("Заключение", numbering: none)
#outro



#bibliography("/authors.bib", style: "/src/gost-r-7-0-5-2008-numeric-alphabetical.csl", title: "Список использованных источников", full: true)

#appendix()

#app
