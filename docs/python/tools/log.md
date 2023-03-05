# 日志

## 0.概述

记日志是一种很好的方式，可以理解程序中发生的事，以及事情发生的顺序。

日志消息将描述程序执行何时到达日志函数调用，并列出你指定的任何变量当时的值。

另一方面，缺失日志信息表明有一部分代码被跳过，从未执行。

python的日志实现有两个库：logging、loguru，下面分别介绍用法。

- 可以在 logging 模块中设置日志等级，在不同的版本（如开发环境、生产环境）上通过设置不同的输出等级来记录对应的日志，非常灵活。
- print 的输出信息都会输出到标准输出流中，而 logging 模块就更加灵活，可以设置输出到任意位置，如写入文件、写入远程服务器等。
- logging 模块具有灵活的配置和格式化功能，如配置输出当前模块信息、运行时间等，相比 print 的字符串格式化更加方便易用。

## 1.logging

### 1.1使用日志模块

logging为Python自带的日志记录工具。

启用logging模块，如下所示：

<details>
<summary>点击展开代码</summary>

```Python
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

logger.info('This is INFO log')
logger.debug('This is DEBUG log')
logger.warning('This is WARNING log')
logging.info('This is INFO log')
logging.debug('This is DEBUG log')
logging.warning('This is WARNING log')

```

</details>

其中，format属性指定了日志输出信息的格式，level属性指定了日志的输出级别。

想打印日志信息时，使用 logging.debug() 函数

<details>
<summary>点击展开代码</summary>

```Python
logging.debug('Start of program')
def factorial(n):
     logging.debug('Start of factorial(%s%%)' % (n))
logging.debug('End of program')
```

</details>

debug() 函数将调用 basicConfig()，打印一行信息。这行信息的格式是我们在 basicConfig()函数中指定的，并且包括我们传递给 debug() 的消息

### 1.2日志级别

“日志级别”提供了一种方式，按重要性对日志消息进行分类。从最不重要到最重要。利用不同的日志函数，消息可以按某个级别记入日志。

日志级别如下表所示：

||||
|-|-|-|
|**级别**|**日志函数**|**描述**|
|DEBUG|logging.debug()|最低级别，用于表示小细节，通常只有在诊断问题时，才会关心这些信息|
|INFO|logging.info()|用于记录程序中一般事件的信息，或确认一切工作正常|
|WARNING|logging.warning()|用于表示可能的问题，它不会阻止程序的工作|
|ERROR|logging.error()|用于记录错误，它导致程序做某事失败|
|CRITICAL|logging.critical()|最高级别，用于表示致命的错误，它导致或将要导致程序完全停止工作|

<details>
<summary>点击展开代码</summary>

```Python
>>> import logging
>>> logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
>>> logging.debug('Some debugging details.')
2015-05-18 19:04:26,901 - DEBUG - Some debugging details.
>>> logging.info('The logging module is working.')
2015-05-18 19:04:35,569 - INFO - The logging module is working.
>>> logging.warning('An error message is about to be logged.')
2015-05-18 19:04:56,843 - WARNING - An error message is about to be logged.
>>> logging.error('An error has occurred.')
2015-05-18 19:05:07,737 - ERROR - An error has occurred.
>>> logging.critical('The program is unable to recover!')
2015-05-18 19:05:45,794 - CRITICAL - The program is unable to recover!
```

</details>

日志级别的好处在于，你可以改变想看到的日志消息的优先级。向basicConfig()函数传入 logging.DEBUG 作为 level 关键字参数，这将显示所有日志级别的消息（DEBUG是最低的级别）。但在开发了更多的程序后，你可能只对错误感兴趣。在这种情况下，可以将 basicConfig() 的 level 参数设置为 logging.ERROR，这将只显示 ERROR和 CRITICAL 消息，跳过 DEBUG、INFO 和 WARNING 消息。

### 1.3输出格式

format：指定日志信息的输出格式，部分参数如下，完整参数请见官网。

- %(levelno) s：打印日志级别的数值。
- %(levelname) s：打印日志级别的名称。
- %(pathname) s：打印当前执行程序的路径，其实就是 sys.argv [0]。
- %(filename) s：打印当前执行程序名。
- %(funcName) s：打印日志的当前函数。
- %(lineno) d：打印日志的当前行号。
- %(asctime) s：打印日志的时间。
- %(thread) d：打印线程 ID。
- %(threadName) s：打印线程名称。
- %(process) d：打印进程 ID。
- %(processName) s：打印线程名称。
- %(module) s：打印模块名称。
- %(message) s：打印日志信息。

### 1.4 Handler

我们可以通过handler来将日志输出到不同的地方，如控制台，文件或者HTTP服务器中。

主要handler如下：

- StreamHandler：logging.StreamHandler；日志输出到流，可以是 sys.stderr，sys.stdout 或者文件。
- FileHandler：logging.FileHandler；日志输出到文件。
- BaseRotatingHandler：logging.handlers.BaseRotatingHandler；基本的日志回滚方式。
- RotatingHandler：logging.handlers.RotatingHandler；日志回滚方式，支持日志文件最大数量和日志文件回滚。
- TimeRotatingHandler：logging.handlers.TimeRotatingHandler；日志回滚方式，在一定时间区域内回滚日志文件。
- SocketHandler：logging.handlers.SocketHandler；远程输出日志到 TCP/IP sockets。
- DatagramHandler：logging.handlers.DatagramHandler；远程输出日志到 UDP sockets。
- SMTPHandler：logging.handlers.SMTPHandler；远程输出日志到邮件地址。
- SysLogHandler：logging.handlers.SysLogHandler；日志输出到 syslog。
- NTEventLogHandler：logging.handlers.NTEventLogHandler；远程输出日志到 Windows NT/2000/XP 的事件日志。
- MemoryHandler：logging.handlers.MemoryHandler；日志输出到内存中的指定 buffer。
- HTTPHandler：logging.handlers.HTTPHandler；通过”GET” 或者”POST” 远程输出到 HTTP 服务器。

下面我们使用三个 Handler 来实现日志同时输出到控制台、文件、HTTP 服务器：

<details>
<summary>点击展开代码</summary>

```Python
import logging
from logging.handlers import HTTPHandler
import sys

logger = logging.getLogger(__name__)
logger.setLevel(level=logging.DEBUG)

# StreamHandler
stream_handler = logging.StreamHandler(sys.stdout)
stream_handler.setLevel(level=logging.DEBUG)
logger.addHandler(stream_handler)

# FileHandler
file_handler = logging.FileHandler('output.log')
file_handler.setLevel(level=logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

# HTTPHandler
http_handler = HTTPHandler(host='localhost:8001', url='log', method='POST')
logger.addHandler(http_handler)

# Log
logger.info('This is a log info')
logger.debug('Debugging')
logger.warning('Warning exists')
logger.info('Finish')
```

</details>

HTTP Server 会收到控制台输出的信息。 这样一来，我们就通过设置多个 Handler 来控制了日志的多目标输出。 另外值得注意的是，在这里 StreamHandler 对象我们没有设置 Formatter，因此控制台只输出了日志的内容，而没有包含时间、模块等信息，而 FileHandler 我们通过 setFormatter () 方法设置了一个Formatter 对象，因此输出的内容便是格式化后的日志信息。 另外每个 Handler 还可以设置 level 信息，最终输出结果的 level 信息会取 Logger 对象的 level 和 Handler 对象的 level 的交集。

### 1.5 捕获Traceback

如果遇到错误，我们更希望报错时出现的详细 Traceback 信息，便于调试，利用 logging 模块我们可以非常方便地实现这个记录。

这里我们在 error () 方法中添加了一个参数，将 exc_info 设置为了 True，这样我们就可以输出执行过程中的信息了，即完整的 Traceback 信息。

<details>
<summary>点击展开代码</summary>

```Python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(level=logging.DEBUG)

# Formatter
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# FileHandler
file_handler = logging.FileHandler('result.log')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

# StreamHandler
stream_handler = logging.StreamHandler()
stream_handler.setFormatter(formatter)
logger.addHandler(stream_handler)

# Log
logger.info('Start')
logger.warning('Something maybe fail.')
try:
    result = 10 / 0
except Exception:
    logger.error('Faild to get result', exc_info=True)
logger.info('Finished')
```

</details>

### 1.6 配置共享

在写项目的时候，我们肯定会将许多配置放置在许多模块下面，这时如果我们每个文件都来配置 logging 配置那就太繁琐了，logging 模块提供了父子模块共享配置的机制，会根据 Logger 的名称来自动加载父模块的配置。

首先定义一个main.py文件：

<details>
<summary>点击展开代码</summary>

```Python
# main.py
import logging
import core

logger = logging.getLogger('main')
logger.setLevel(level=logging.DEBUG)

# Handler
handler = logging.FileHandler('result.log')
handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

logger.info('Main Info')
logger.debug('Main Debug')
logger.error('Main Error')
core.run()

```

</details>

接下来我们定义core.py，内容如下：

<details>
<summary>点击展开代码</summary>

```Python
# core.py
import logging

logger = logging.getLogger('main.core')

def run():
    logger.info('Core Info')
    logger.debug('Core Debug')
    logger.error('Core Error')

```

</details>

core.py里面的 Logger 就会复用main.py里面的 Logger 配置，而不用再去配置一次了。 运行之后会生成一个 result.log 文件

输出结果如下：

<details>
<summary>点击展开代码</summary>

```Bash
2018-06-03 16:55:56,259 - main - INFO - Main Info
2018-06-03 16:55:56,259 - main - ERROR - Main Error
2018-06-03 16:55:56,259 - main.core - INFO - Core Info
2018-06-03 16:55:56,259 - main.core - ERROR - Core Error

```

</details>

可以看到父子模块都使用了同样的输出配置。 如此一来，我们只要在入口文件里面定义好 logging 模块的输出配置，子模块只需要在定义 Logger 对象时名称使用父模块的名称开头即可共享配置，非常方便。

### 1.7文件配置

在开发过程中，将配置在代码里面写死并不是一个好的习惯，更好的做法是将配置写在配置文件里面，我们可以将配置写入到配置文件，然后运行时读取配置文件里面的配置，这样是更方便管理和维护的，首先我们定义一个 yaml 配置文件：

<details>
<summary>点击展开代码</summary>

```YAML
// config.yaml
version: 1
formatters:
  brief:
    format: "%(asctime)s - %(message)s"
  simple:
    format: "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
handlers:
  console:
    class : logging.StreamHandler
    formatter: brief
    level   : INFO
    stream  : ext://sys.stdout
  file:
    class : logging.FileHandler
    formatter: simple
    level: DEBUG
    filename: debug.log
  error:
    class: logging.handlers.RotatingFileHandler
    level: ERROR
    formatter: simple
    filename: error.log
    maxBytes: 10485760
    backupCount: 20
    encoding: utf8
loggers:
  main.core:
    level: DEBUG
    handlers: [console, file, error]
root:
  level: DEBUG
  handlers: [console]
```

</details>

这里我们定义了 formatters、handlers、loggers、root 等模块，实际上对应的就是各个 Formatter、Handler、Logger 的配置，参数和它们的构造方法都是相同的。 接下来我们定义一个主入口文件，main.py，内容如下：

<details>
<summary>点击展开代码</summary>

```Python
# main.py
import logging
import core
import yaml
import logging.config
import os


def setup_logging(default_path='config.yaml', default_level=logging.INFO):
    path = default_path
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            config = yaml.load(f)
            logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=default_level)


def log():
    logging.debug('Start')
    logging.info('Exec')
    logging.info('Finished')


if __name__ == '__main__':
    yaml_path = 'config.yaml'
    setup_logging(yaml_path)
    log()
    core.run()
```

</details>

我们定义 core.py如下：

<details>
<summary>点击展开代码</summary>

```Python
import logging

logger = logging.getLogger('main.core')

def run():
    logger.info('Core Info')
    logger.debug('Core Debug')
    logger.error('Core Error')
```

</details>

通过配置文件，我们可以非常灵活地定义 Handler、Formatter、Logger 等配置，同时也显得非常直观，也非常容易维护，在实际项目中，推荐使用此种方式进行配置。 以上便是 logging 模块的基本使用方法，有了它，我们可以方便地进行日志管理和维护，会给我们的工作带来极大的方便。

### 1.8禁用日志

在调试完成后，你需要从代码中清除每条日志消息的 print() 调用，这将会消耗你很多时间。

你甚至有可能不小心删除一些 print() 调用，而它们不是用来产生日志消息的。

日志消息的好处在于，你可以随心所欲地在程序中想加多少就加多少，稍后只要加入如下代码，就可以禁止日志。

<details>
<summary>点击展开代码</summary>

```Python
logging.disable(logging.CRITICAL)
```

</details>

不像 print()，logging 模块使得显示和隐藏日志信息之间的切换变得很容易。

同样，还可以根据不同的日志级别，禁用不同的日志消息。

<details>
<summary>点击展开代码</summary>

```python
logging.disable(logging.INFO)
logging.disable(logging.DEBUG)
```

</details>

日志消息是给程序员的，不是给用户的。对于用户希望看到的消息，例如“文件未找到”或者“无效的输入，请输入一个数字”，应该使用 print() 调用。我们不希望禁用日志消息之后，让用户看不到有用的信息。

### 1.9 日志输出格式化

<details>
<summary>点击展开代码</summary>

```Python
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# bad
logging.debug('Hello {0}, {1}!'.format('World', 'Congratulations'))
# good
logging.debug('Hello %s, %s!', 'World', 'Congratulations')
```

</details>

logging模块提供了字符串格式化方法，我们只需要在第一个参数写上要打印输出的模板，占位符用%s、%d等表示即可，然后在后续参数添加对应的值就可以了，推荐使用这种方法。

## 2.loguru

安装：pip install loguru

logging的一些配置相对来说还是比较繁琐的，这里有另一个库loguru使用起来更方便。

### 2.1使用示例

<details>
<summary>点击展开代码</summary>

```Python
from loguru import logger

logger.debug('This is a debug message')
```

</details>

输出结果如下：

<details>
<summary>点击展开结果</summary>

```Bash
2022-04-09 11:52:39.141 | DEBUG    | __main__:<module>:3 - This is a debug message
```

</details>

不需要配置什么东西，直接引入一个 logger，然后调用其 debug 方法即可。 在 loguru 里面有且仅有一个主要对象，那就是 logger，loguru 里面有且仅有一个 logger，而且它已经被提前配置了一些基础信息，比如比较友好的格式化、文本颜色信息等等。

如果想要输出到其他的位置，比如存为文件，我们只需要使用一行代码声明即可。

<details>
<summary>点击展开代码</summary>

```Python
from loguru import logger

logger.add('runtime.log')
logger.debug('this is a debug')
```

</details>

我们也不需要再声明一个 FileHandler 了，就一行 add 语句搞定，运行之后会发现目录下 runtime.log 里面同样出现了刚刚控制台输出的 DEBUG 信息。

### 2.2 add()方法

loguru 对输出到文件的配置有非常强大的支持，比如支持输出到多个文件，分级别分别输出，过大创建新文件，过久自动删除等等。 下面我们分别看看这些怎样来实现，这里基本上就是 add 方法的使用介绍。

因为这个 add 方法就相当于给 logger 添加了一个 Handler，它给我们暴露了许多参数来实现 Handler 的配置，下面我们来详细介绍下。 首先看看它的方法：

<details>
<summary>点击展开代码</summary>

```Python
def add(
        self,
        sink,
        *,
        level=_defaults.LOGURU_LEVEL,
        format=_defaults.LOGURU_FORMAT,
        filter=_defaults.LOGURU_FILTER,
        colorize=_defaults.LOGURU_COLORIZE,
        serialize=_defaults.LOGURU_SERIALIZE,
        backtrace=_defaults.LOGURU_BACKTRACE,
        diagnose=_defaults.LOGURU_DIAGNOSE,
        enqueue=_defaults.LOGURU_ENQUEUE,
        catch=_defaults.LOGURU_CATCH,
        **kwargs
    ):
    pass
```

</details>

### 2.3 sink参数

- sink 可以传入一个 file 对象，例如 `sys.stderr` 或者 `open('file.log', 'w')` 都可以。
- sink 可以直接传入一个 `str` 字符串或者 `pathlib.Path` 对象，其实就是代表文件路径的，如果识别到是这种类型，它会自动创建对应路径的日志文件并将日志输出进去。
- sink 可以是一个方法，可以自行定义输出实现。
- sink 可以是一个 logging 模块的 Handler，比如 FileHandler、StreamHandler 等等，或者上文中我们提到的 CMRESHandler 照样也是可以的，这样就可以实现自定义 Handler 的配置。
- sink 还可以是一个自定义的类，具体的实现规范可以参见官方文档。
- 另外添加 sink 之后我们也可以对其进行删除，相当于重新刷新并写入新的内容。 删除的时候根据刚刚 add 方法返回的 id 进行删除即可。

<details>
<summary>点击展开代码</summary>

```Python
from loguru import logger

trace = logger.add('runtime.log')
logger.debug('this is a debug message')
logger.remove(trace)
logger.debug('this is another debug message')

```

</details>

### 2.4 其他参数

其他参数用法和 logging 模块都是基本一样的，例如这里使用 format、filter、level 来规定输出的格式：

<details>
<summary>点击展开代码</summary>

```Python
logger.add('runtime.log', format="{time} {level} {message}", filter="my_module", level="INFO")

```

</details>

### 2.5 rotation配置

用了 loguru 我们还可以非常方便地使用 rotation 配置，比如我们想一天输出一个日志文件，或者文件太大了自动分隔日志文件，我们可以直接使用 add 方法的 rotation 参数进行配置。 

<details>
<summary>点击展开代码</summary>

```Python
logger.add('runtime_{time}.log', rotation="500 MB")

```

</details>

过这样的配置我们就可以实现每 500MB 存储一个文件，每个 log 文件过大就会新创建一个 log 文件。我们在配置 log 名字时加上了一个 time 占位符，这样在生成时可以自动将时间替换进去，生成一个文件名包含时间的 log 文件。 另外我们也可以使用 rotation 参数实现定时创建 log 文件。

<details>
<summary>点击展开代码</summary>

```Python
logger.add('runtime_{time}.log', rotation='00:00')
```

</details>

这样就可以实现每天 0 点新创建一个 log 文件输出了。 另外我们也可以配置 log 文件的循环时间，比如每隔一周创建一个 log 文件。

<details>
<summary>点击展开代码</summary>

```python
logger.add('runtime_{time}.log', rotation='1 week')

```

</details>

这样我们就可以实现一周创建一个 log 文件了。

### 2.6 retention 配置

retention 这个参数可以配置日志的最长保留时间。

比如我们想要设置日志文件最长保留 10 天，可以这么来配置。

<details>
<summary>点击展开代码</summary>

```Python
logger.add('runtime.log', retention='10 days')

```

</details>

这样 log 文件里面就会保留最新 10 天的 log。

### 2.7 compression 配置

compression参数可以配置文件的压缩格式，比如使用 zip 文件格式保存。
<details>
<summary>点击展开代码</summary>

```Python
logger.add('runtime.log', compression='zip')

```

</details>

### 2.8 字符串格式化

loguru 在输出 log 的时候还提供了非常友好的字符串格式化功能。

<details>
<summary>点击展开代码</summary>

```Python
logger.info('If you are using Python {}, prefer {feature} of course!', 3.6, feature='f-strings')

```

</details>

### 2.9 Traceback记录

loguru用它提供的装饰器就可以直接进行 Traceback 的记录，类似这样的配置即可。

<details>
<summary>点击展开代码</summary>

```Python
@logger.catch
def my_function(x, y, z):
    # An error? It's caught anyway!
    return 1 / (x + y + z)
```

</details>

用如下命令调用：

<details>
<summary>点击展开代码</summary>

```Python
my_function(0, 0, 0)

```

</details>

更多loguru的强大功能请查找官方文档。

## 3.参考内容

原文：

[https://cuiqingcai.com/6080.html](https://cuiqingcai.com/6080.html)

[https://cuiqingcai.com/7776.html](https://cuiqingcai.com/7776.html)

其他资料：

[https://docs.python.org/3/library/logging.html](https://docs.python.org/3/library/logging.html)

[https://loguru.readthedocs.io/en/stable/index.html](https://loguru.readthedocs.io/en/stable/index.html)