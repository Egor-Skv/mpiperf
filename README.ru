MPIPerf
-------

MPIPerf - это пакет для измерения времени выполнения коммуникационных функций
библиотек стандарта MPI.

Установка
---------

Перед установкой необходимо указать в файле 'Makefile.inc' пути к компилятору 
с языка C и библиотеке стандарта MPI. В каталоге config размещены примеры 
файлов 'Makefile.inc' для различных компиляторов. Сборка mpiperf выполняется 
командой:

    $ make

При успешной сборке исполняемый файл mpiperf будет находится в каталоге src.

Подготовка к выполнению тестов
------------------------------

Перед выполнением тестов рекомендуется запустить mpiperf в режиме проверки
корректности работы таймеров на вычислительных узлах системы. Здесь и далее все 
примеры будут приводиться в предположении, что запуск mpiperf осуществляется 
утилитой mpiexec.

Список поддерживаемых таймеров запрашивается командой:

    $ mpiexec -n 1 ./mpiperf -T

Рекомендуется выполнить тест таймера, который планируется использовать
(по умолчанию используется таймер MPI_Wtime):

    $ mpiexec -n 1 ./mpiperf -g -t tsc

В случае корректной работы таймера выдается сообщение PASSED.

Далее рекомендуется проверить модуль обеспечивающий синхронизацию показаний
локальных часов процессов. Тест следует запускать на нескольких узлах:

    $ mpiexec -n 64 ./mpiperf WaitPatternNull

Время выполнения теста (столбец [Mean]) должно быть 0.XX микросекунд. 
Значения больше 1 микросекунды (1.XX) свидетельствуют о некорректной
синхронизации процессов. Следует проверить другие таймеры mpiperf.

В каталоге examples/WaitPatternNull приведены результаты выполнения теста
на различных вычислительных системах.

Выполнение тестов
-----------------

Список доступных тестов запрашивается командой:

    $ ./mpiperf -q

Каждый тест имеет варьируемый параметр (количество процессов, размер сообщения),
минимальное и максимальное значение которого задаются через опции -x и -X,
соответственно.

Опции -e и -E позволяют задать условие окончания измерений для каждого значения
варьируемого параметра.

Пример выполнения теста для функции MPI_Bcast (размер сообщения изменяется
по геометрической прогрессии с шагом 2):

    $ mpiexec -n 32 ./mpiperf -t tsc -x1024 -X64KiB -S2 Bcast

Пример выполнения теста для функции MPI_Barrier (количество процессов участвующих
в выполнении операции изменяется по арифметической прогрессии с шагом 4):

    $ mpiexec -n 64 ./mpiperf -t tsc -x1 -X64 -s4 Barrier

Поддержка
---------

Вопросы по реализации и поддержке следует направлять 
Курносову Михаилу Георгиевичу
e-mail: mkurnosov@gmail.com
http://cpct.sibsutis.ru/~mkurnosov
