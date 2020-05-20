# Обзор языка программирования Rust
**Rust** — новый экспериментальный язык программирования, разрабатываемый Mozilla. Язык компилируемый и мультипарадигмальный, позиционируется как альтернатива С/С++, что уже само по себе интересно, так как даже претендентов на конкуренцию не так уж и много. Можно вспомнить D Вальтера Брайта или Go от Google.
В Rust поддерживаются функицональное, параллельное, процедурное и объектно-ориентированное программирование, т.е. почти весь спектр реально используемых в прикладном программировании парадигм.

Информация собрана как из официальной документации, так и из крайне немногочисленных упоминаний языка на просторах Интернета.



## Первое впечатление

Синтаксис языка строится в традиционном си-подобном стиле (что не может не радовать, так как это уже стандарт де-факто). Естественно, всем известные ошибки дизайна С/С++ учтены.
Традиционный Hello World выглядит так:
```
use std;
fn main(args: [str]) {
    std::io::println("hello world from " + args[0] + "!");
}
```


Пример чуть посложнее — функция расчета факториала:

```
fn fac(n: int) -> int {
    let result = 1, i = 1;
    while i <= n {
        result *= i;
        i += 1;
    }
    ret result;
}
```


Как видно из примера, функции объявляются в «функциональном» стиле (такой стиль имеет некоторые преимущества перед традиционным «*int fac(int n)*»). Видим **автоматический вывод типов** (ключевое слово let), отсутствие круглых скобок у аргумента while (аналогично Go). Еще сразу бросается в глаза компактность ключевых слов. Создатели Rust дейтсвительно целенаправленно сделали все ключевые слова как можно более короткими, и, скажу честно, мне это нравится.

## Мелкие, но интересные синтаксические особенностиМелкие, но интересные синтаксические особенности

- В числовые константы можно вставлять подчеркивания. Удобная штука, сейчас эту возможность добавляют во многие новые языки.
`0xffff_ffff_ffff_ffff_ffff_ffff`
- Двоичные константы. 
`0b1111_1111_1001_0000`
- Тела любых операторов (даже состоящие из единственного выражения) должны быть обязательно заключены в фигурные скобки. К примеру, в Си можно было написать `if(x>0) foo();`, в Rust нужно обязательно поставить фигурнные скобки вокруг `foo()`.
- Зато аргументы операторов` if`, `while` и подобных не нужно заключать в круглые скобки.
- Во многих случаях блоки кода могут рассматриваться как выражения. В частности, возможно, например, такое:
```
 let x = if the_stars_align() { 4 }
         else if something_else() { 3 }
         else { 0 };
```
- Синтаксис объявления функций — сначала ключевое слово `fn`, затем список аргументов, тип аргумента указывается после имени, затем, если функция возвращает значение — стрелочка `->` и тип возвращаемого значения.
- Аналогичным образом объявляются переменные: ключевое слово `let`, имя переменной, после переменной можно через двоеточие уточнить тип, и затем — присвоить начальное значение.
```
 let count: int = 5;
```
- По умолчанию все переменные неизменяемые; для объявления изменяемых переменных используется ключевое слово `mutable`.
- Имена базовых типов — самые компактные из всех, которые мне встречались: `i8, i16, i32, i64, u8, u16, u32, u64,f32, f64`.
- Как уже было сказано выше, поддерживается автоматический вывод типов.

В языке присутствую встроенные средства отладки программ:
Ключевое слово **fail** завершает текущий процесс
Ключевое слово **log** выводит любое выражение языка в лог (например, в stderr)
Ключевое слово **assert** проверяет выражение, и если оно ложно, завершает текущий процесс
Ключевое слово **note** позволяет вывести дополнительную инфорацию в случае аварийного завершения процесса.

## Типы данных

Rust, подобно Go, поддерживает **структурную типизацию** (хотя, по утверждению авторов, языки развивались независимо, так что это влияние их общих предшественников — Alef, Limbo и т.д.). Что такое структурная типизация? Например, у вас в каком-то файле объявлена структура (или, в терминологии Rust, «`запись`»)
```
    type point = {x: float, y: float};
```
Вы можете объявить кучу переменных и функций с типами аргументов `point`. Затем, где-нибудь в другом месте, вы можете объявить какую-нибудь другую структуру, например
```
type MySuperPoint = {x: float, y: float};
```
и переменные этого типа будут полностью совместимы с переменными типа `point`.

В противоположность этому, номинативная типизация, принятая в С, С++, C# и Java таких конструкций не допускает. При номинативной типизации каждая структура — это уникальный тип, по умолчанию несовместимый с другими типами.

Структуры в Rust называются «`записи`» (record). Также имеются кортежи — это те же записи, но с безымянными полями. Элементы кортежа, в отличие от элементов записи, не могут быть изменяемыми.

Имеются вектора — в чем-то подобные обычным массивам, а в чем-то — типу `std::vector` из `stl`. При инициализации списком используются квадратные скобки, а не фигурные как в С/С++

```
let myvec = [1, 2, 3, 4];
```


Вектор, тем ни менее — динамическая структура данных, в частности, вектора поддерживают конкатенацию.

```
let v: mutable [int] = [1, 2, 3];
v += [4, 5, 6];
```


Есть шаблоны. Их синтаксис вполне логичен, без нагромождений «template» из С++. Поддерживаются шаблоны функций и типов данных.


```
fn for_rev<T>(v: [T], act: block(T)) {
    let i = std::vec::len(v);
    while i > 0u {
        i -= 1u;
        act(v[i]);
    }
}

type circular_buf<T> = {start: uint,
                        end: uint,
                        buf: [mutable T]};
```


Язык поддерживает так называемые **теги**. Это не что иное, как union из Си, с дополнительным полем — кодом используемого варианта (то есть нечто общее между объединением и перечислением). Или, с точки зрения теории — алгебраический тип данных.

```
tag shape {
    circle(point, float);
    rectangle(point, point);
}

```

В простейшем случае тег идентичен перечислению:

```
tag animal {
       dog;
       cat;
     }
let a: animal = dog;
a = cat;
```

В более сложных случаях каждый элемент «перечисления» — самостоятельная структура, имеющая свой «конструктор».
Еще интересный пример — рекурсивная структура, с помощью которой задается объект типа «список»:
```
tag list<T> {
       nil;
       cons(T, @list<T>);
     }
let a: list<int> = cons(10, @cons(12, @nil));
```

Теги могут участвовать в выражениях сопоставления с образцом, которые могут быть достаточно сложными.
```
alt x {
         cons(a, @cons(b, _)) {
             process_pair(a,b);
         }
         cons(10, _) {
             process_ten();
         }
         _ {
             fail;
         }
     }
```


## Сопоставление с образцом (pattern matching)

Для начала можно рассматривать паттерн матчинг как улучшенный switch. Используется ключевое слово alt, после которого следует анализируемое выражение, а затем в теле оператора — паттерны и действия в случае совпадения с паттернами.
```
alt my_number {
  0       { std::io::println("zero"); }
  1 | 2   { std::io::println("one or two"); }
  3 to 10 { std::io::println("three to ten"); }
  _       { std::io::println("something else"); }
}
```

В качестве «паттеронов» можно использовать не только константы (как в Си), но и более сложные выражения — переменные, кортежи, диапазоны, типы, символы-заполнители (placeholders, '_').
Можно прописывать дополнительные условия с помощью оператора when, следующего сразу за паттерном. Существует специальный вариант оператора для матчинга типов. Такое возможно, поскольку в языке присутствует универсальный вариантный тип any, объекты которого могут содержать значения любого типа.

**Указатели**. Кроме обычных «сишных» указателей, в Rust поддерживаются специальные «умные» указатели со встроенным подсчетом ссылок — разделяемые (Shared boxes) и уникальные (Unique boxes). Они в чем-то подобны shared_ptr и unique_ptr из С++. Они имеют свой синтаксис: @ для разделяемых и ~ для уникальных. Для уникальных указателей вместо копирования существует специальная операция — перемещение:
```
let x = ~10;
let y <- x;
```

после такого перемещения указатель x деинициализируется.

## Замыкания, частичное применение, итераторы

С этого места начинается функциональное программирование. В Rust полностью поддерживается концепция функций высшего порядка — то есть функций, которые могут принимать в качестве своих аргументов и возвращать другие функции.

1. Ключевое слово **lambda** используется для объявления вложенной функции или функционального типа данных.
```
fn make_plus_function(x: int) -> lambda(int) -> int {
    lambda(y: int) -> int { x + y }
}
let plus_two = make_plus_function(2);
assert plus_two(3) == 5;
```

	В этом примере мы имеем функцию make_plus_function, принимающую один аргумент «x» типа int и возвращающую функцию типа «int->int» (здесь lambda — ключевое слово). В теле функции описывается эта самая фунция. Немного сбивает с толку отсутствие оператора «return», впрочем, для ФП это обычное дело.

2. Ключевое слово block используется для объявления функционального типа — аргумента функции, в качестве которого можно подставить нечто, похожее на блок обычного кода.
```
fn map_int(f: block(int) -> int, vec: [int]) -> [int] {
    let result = [];
    for i in vec { result += [f(i)]; }
    ret result;
}
map_int({|x| x + 1 }, [1, 2, 3]);
```

	Здесь мы имеем функцию, на вход которой подается блок — по сути лямбда-функция типа «int->int», и вектор типа int (о синтаксисе векторов далее). Сам «блок» в вызывающем коде записыавется с помощью несколько необычного синтаксиса {|x| x + 1 }. Лично мне больше нравятся лямбды в C#, символ | упорно воспринимается как битовое ИЛИ (которое, кстати, в Rust также есть, как и все старые добные сишные операции).

3. Частичное применение — это создание функции на основе другой функции с большим количеством аргументов путем указания значений некоторых аргументов этой другой функции. Для этого используется ключевое слово bind и символ-заполнитель "_":
```
let daynum = bind std::vec::position(_, ["mo", "tu", "we", "do", "fr", "sa", "su"])
```

	Чтобы было понятнее, скажу сразу, что такое можно сделать на обычном Си путем создания простейшей обертки, как-то так:
```
const char* daynum (int i) { const char *s ={"mo", "tu", "we", "do", "fr", "sa", "su"}; return s[i]; }
```

	Но частичное применение — это функциональный стиль, а не процедурный (кстати, из приведенного примера неясно, как сделать частичное применение, чтобы получить функцию без аргументов)

	Еще пример: объявляется функция `add` с двумя аргументами int, возвращающая `int`. Далее объявляется функциональный тип `single_param_fn`, имеющий один аргумент `int` и возвращающий `int`. С помощью bind объявляются два функциональных объекта `add4` и `add5`, построенные на основе функции `add`, у которой частично заданы аргументы.
	
```
fn add(x: int, y: int) -> int {
         ret x + y;
     }
type single_param_fn = fn(int) -> int;

let add4: single_param_fn = bind add(4, _);
let add5: single_param_fn = bind add(_, 5);
```
Функциональные объекты можно вызывать также, как и обычные функции.
assert (add(4,5) == add4(5));
assert (add(4,5) == add5(4));

4. Чистые функции и предикаты
Чистые (pure) функции — это функции, не имеющие побочных эффектов (в том числе не вызывающие никаких других функций, кроме чистых). Такие функции выдяляются ключевым словом pure.
     ```
pure fn lt_42(x: int) -> bool {
         ret (x < 42);
     }
```

Предикаты — это чистые (pure) функции, возвращающие тип bool. Такие функции могут использоваться в системе typestate (см. дальше), то есть вызываться на этапе компиляции для различных статических проверок.

Синтаксические макросы
Планируемая фича, но очень полезная. В Rust она пока на стадии начальной разработки.
std::io::println(#fmt("%s is %d", "the answer", 42));

Выражение, аналогичное сишному printf, но выполняющееся во время компиляции (соответственно, все ошибки аргументов выявляются на стадии компиляции). К сожалению, материалов по синтаксическим макросам крайне мало, да и сами они находятся в стадии разработки, но есть надежда что получится что-то типа макросов Nemerle.
Кстати, в отличие от того же Nemerle, решение выделить макросы синтаксически с помощью символа # считаю очень грамотным: макрос — это сущность, очень сильно отличающаяся от функции, и я считаю важным с первого взгляда видеть, где в коде вызываются функции, а где — макросы.

Атрибуты

Концепция, похожая на атрибуты C# (и даже со схожим синтаксисом). За это разработчикам отдельное спасибо. Как и следовало ожидать, атрибуты добавляют метаинформацию к той сущности, которую они аннотируют,
#[cfg(target_os = "win32")]
fn register_win_service() { /* ... */ }

Придуман еще один вариант синтаксиса атрибутов — та же строка, но с точкой с запятой в конце, аннотирует текущий контекст. То есть то, что соответствует ближайшим фигурным скобкам, охватывающим такой атрибут.
fn register_win_service() {
    #[cfg(target_os = "win32")];
    /* ... */
}


Параллельные вычисления

Пожалуй, одна из наиблее интересных частей языка. При этом в tutorial на данный момент не описана вообще:)
Программа на Rust состоит из «дерева задач». Каждая задача имеет функцию входа, собственный стек, средства взаимодействия с другими задачами — каналы для исходящей информации и порты для входящей, и владеет некоторой частью объектов в динамической куче.
Множество задач Rust могут существовать в рамках одного процесса операционной системы. Задачи Rust «легковесные»: каждая задача потребляет меньше памяти чем процесс ОС, и переключение между ними осуществляется быстрее чем переключение между процессами ОС (тут, вероятно, имеются в виду все-же «потоки»).

Задача состоит как минимум из одной функции без аргументов. Запуск задачи осуществляется с помощью функции spawn. Каждая задача может иметь каналы, с помощью которых она передает инфорацию другим задачам. Канал — это специальный шаблонный тип chan, параметризируемый типом данных канала. Например, chan — канал для передачи беззнаковых байтов.
Для передачи в канал используется функция send, первым аргументом которой является канал, а вторым — значение для передачи. Фактически эта функция помещает значение во внутренний буфер канала.
Для приема данных используются порты. Порт — это шаблонный тип port, параметризируемый типом данных порта: port — порт для приема беззнаковых байтов.
Для чтения из портов используется функция recv, аргументом которой является порт, а возвращаемым значением — данные из порта. Чтение блокирует задачу, т.е. если порт пуст, задача переходит в состояние ожидания до тех пор, пока другая задача не отправит на связанный с портом канал данные.
Связывание каналов с портами происходит очень просто — путем инициализации канала портом с помощью ключевого слова chan:
```
let reqport = port();
let reqchan = chan(reqport);
```
Несколько каналов могут быть подключены к одному порту, но не наоборот — один канал не может быть подключен одновременно к нескольким портам.

Typestate

Общепринятого перевода на русский понятия «typestate» я так и не нашел, поэтому буду называть это «состояния типов». Суть этой фичи в том, что кроме обычного контроля типов, принятого в статической типизации, возможны дополнительные контекстные проверки на этапе компиляции.
В том или ином виде состояния типов знакомы всем программистам — по сообщениям компилятора «переменная используется без инициализации». Компилятор определяет места, где переменная, в которую ни разу не было записи, используется для чтения, и выдает предупреждение. В более общем виде эта идея выглядит так: у каждого объекта есть набор состояний, которые он может принимать. В каждом состоянии для этого объекта определены допустимые и недопустимые операции. И компилятор может выполнять проверки — допустима ли конкретная операция над объектом в том или ином месте программы. Важно, что эти проверки выполняются на этапе компиляции.

Например, если у нас есть объект типа «файл», то у него может быть состояние «закрыт» и «открыт». И операция чтения из файла недопустима, если файл закрыт. В современных языках обычно функция чтения или бросает исключение, или возвращает код ошибки. Система состояний типов могла бы выявить такую ошибку на этапе компиляции — подобно тому, как компилятор определяет, что операция чтения переменной происходит до любой возможной операции записи, он мог бы определить, что метод «Read», допустимый в состоянии «файл открыт», вызывается до метода «Open», переводящего объект в это состояние.

В Rust существует понятие «предикаты» — специальные функции, не имеющие побочных эффектов и возвращающие тип `bool`. Такие функции могут использоваться компилятором для вызова на этапе компиляции с целью статических проверок тех или иных условий.

Ограничения (constraints) — это специальные проверки, которые могут выполняться на этапе компиляции. Для этого используется ключевое слово check.
```
pure fn is_less_than(int a, int b) -< bool {
          ret a < b;
     }
 fn test() {
   let x: int = 10;
   let y: int = 20;
   check is_less_than(x,y);
 }
```

Предикаты могут «навешиваться» на входные параметры функций таким вот способом:
```
fn test(int x, int y) : is_less_than(x,y) { ... }
```


Информации по `typestate` крайне мало, так что многие моменты пока непонятны, но концепция в любом случае интересная.

На этом все. При желании можно уже сейчас собрать компилятор Rust и попробовать поиграться с различными примерами. Информация по сборке приведена на [официальном сайте языка](https://www.rust-lang.org/ru/ "официальном сайте языка").
