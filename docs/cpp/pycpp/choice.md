# 如何选择Python与C++之间的胶水

> 引用自: https://zyxin.xyz/blog/2019-08/glue-python-cpp/

Python作为一门胶水语言，它与C/C++之间的兼容性（Interoperability）我认为是它相比其他动态语言脱颖而出的最大原因。Python原生支持的是与C语言的接口，Python的发行版自带有Python.h头文件，里面提供了在C中调用Python和反过来在Python中调用C的接口定义。但是C++就不一样了，虽然C++ ⇔ C ⇔ Python的通道是可行的，但是想要完整兼容C++的特性的话需要很多额外的重复代码（boilerplate）。因此相应针对Python/C++绑定的库也就应运而生了，我所了解的库主要有四个：[Boost.Python](https://www.boost.org/doc/libs/1_70_0/libs/python/doc/html/index.html)，[Cython](https://cython.org/)，[pybind11](https://pybind11.readthedocs.io/en/stable/)，[SWIG](http://www.swig.org/)。虽然网上也有不少比较三者的页面，但是我觉得都不够详细，这篇博客就介绍一下我基于使用这几个库的经验比较。

上面说到的这些库我基本都有接触过，其中用过的有pybind11和Cython，分别用在了我正在写的[CGAL](https://github.com/cmpute/cgal.py)和[PCL](https://github.com/cmpute/pcl.py)的绑定上。另外二者则是在其他库的代码中有读过（如Caffe和CGAL的官方绑定）。总的来说，Boost.Python和pybind11主要用于给现有C++代码提供Python绑定，并且不用学习新的语法;SWIG提供一个给C++代码编写多种语言绑定的框架，它本质上是一种代码生成器，基于SWIG自定义的语法;Cython则是基于Python的C/C++代码封装器，其本质也是代码生成器，但是Cython的语法是Python的超集，也就是说Python的代码可以零成本移植到Cython中。


## Boost.Python vs pybind11

Boost.Python是一个Boost框架中封装C++代码的工具，通过宏定义和元编程来简化Python的API调用，消灭bolierplate。Boost.Python还提供对Numpy底层API的封装，因此适用性很强，能满足Python绑定的绝大多数需求。而pybind11则是受Boost.Python启发的一套类似的API，其目标是提供Header-only的易用的Python接口。由于pybind11脱胎于Boost，因此它们的接口非常相似，例如最简单的封装一个函数，Boost.Python代码如下

<details>
<summary>点击展开代码</summary>

```cpp title="boost_python.cpp"
#include <boost/python.hpp>

int add(int i, int j) {
    return i + j;
}

BOOST_PYTHON_MODULE(example)
{
    using namespace boost::python;
    def("add", add);
}
```

</details>

而对应的pybind11代码则是

<details>
<summary>点击展开代码</summary>

```cpp title="pybind11.cpp"
#include <pybind11/pybind11.h>

int add(int i, int j) {
    return i + j;
}

PYBIND11_MODULE(example, m) {
    m.def("add", &add);
}
```

</details>


因此熟练掌握这两者之一的开发者能很快上手另一个库的使用。他们的编译方式也是相似的，只需添加一个工程，写好对应的封装代码，然后利用他们的CMake模块进行编译，生成的动态链接库只要文件名正确就可以直接从Python进行import了。他们二者的区别主要有以下几个方面：

1. pybind11是Header-only的，因此只需把它的头文件添加到include目录就算安装好了。而Boost.Python则是需要先编译安装才能使用，需要处理其依赖。

2. pybind11的社区更加活跃，Boost.Python则受限于Boost的更新周期，回应反馈可能会比较慢。

3. pybind11的易用性更好，文档齐全且友善，由于没有依赖问题，编译方便上手也快。

4. Boost.Python兼容旧特性的C++，也兼容Boost自定义的类型（如smartptr），因此如果需要封装的代码是基于Boost的，那可能Boost.Python会比pybind11合适。pybind11针对的环境则是C++1x，并且只支持标准C++库。

5. Boost.Python对Numpy的支持比较完备，例如Boost.Python支持自定义numpy.dtype，而pybind11对Numpy的支持主要基于Python的buffer协议。 因此基本上如果封装不基于Boost的库的话可以先考虑pybind11，而如果是封装基于Boost的库（如PCL），或者深度操作Numpy，那还是直接上Boost.Python吧～


## Boost.Python/pybind11 vs Cython

这两者的选用其实差别非常大，因为他们的代码逻辑都是不同的。而具体选择哪个库就纯粹是根据需求出发了。他们的区别如下（以下pybind11同时也代表了Boost.Python）

1. pybind11基于C++，更适合C++工程师。Cython则是基于Python，写习惯的Python的人上手更快，并且能同时方便地兼容Python和C++。

2. Cython相比pybind11的环境配置更加简单，用户只需通过pip安装Cython就可以利用Cython的功能了，也无需配置路径。

3. Cython封装C++类会比Boost.Python更加繁杂，你需要先定义C++类，再封装成Python类。相当于Cython还多一步翻译头文件的工作。

4. Cython支持模板（虽然是阉割版本）！这是Cython独家的一个killer特性，不过是与第3点相关联的。如果你已经翻译好了现有的模板代码，那么用户就可以用Python的语法来自行展开模板了！pybind11需要在编译的时候实例化模板，因此一般只封装常用的实例，或者穷举所有实例化可能（这会导致生成的封装库尺寸爆炸）

5. pybind11封装重载函数比Cython要方便太多！Cython封装重载函数的话一般需要定义大量的可选参数和类型判断。

6. Cython封装继承类就更加麻烦了，不仅要处理方法重载，还要复制继承关系，十分繁复。

7. Cython无法利用上C++的宏定义，这对支持条件编译非常不利，很多时候还需要自己利用Cython的条件语句翻译一套条件编译的逻辑。

8. Cython似乎在封装上比pybind11性能好，参见pybind11#1227和pybind#2005。如果你的代码需要经常调用封装后的函数，那么选择Cython性能更好。

以前很多人使用Cython的原因是Cython可以很方便地加速Python代码，但是numba.jit的出现则让这个功能实际上成了鸡肋，因此Cython最近的使用率也是越来越低了。如果没有很强的对保留模板灵活性的需求，或者不是封装目标不是基于C语言的，那还是选择pybind11来的方便。如果封装接口只是一小部分需求的话也还是用Cython会更加一致，我在自己的PCL绑定项目中使用Cython的原因是有大量基于Python的扩展代码，因此使用Cython还是能更方便。

## SWIG

SWIG是个很神奇的东西，他能够将C++代码封装成Python/C#/Java/Ruby等多种语言，但是也正因为这个灵活性，它对C++的高级特性的支持就比较辣鸡了。在CGAL官方的绑定库中可以看到有不少代码需要针对Python和Java打补丁，因此如果没有多语言的需求的话SWIG应该是下下策了。这应该也是SWIG一直没啥发展的原因吧～


## 小结

总而言之，如果有多语言绑定的需求可以选择SWIG，如果有以下需求可以选择Cython，其他情况选择pybind11即可

- 需要保留模板参数，让用户可以自行选择用什么类型展开，或者目标用户有继续使用和拓展C++ API的需求时，用Cython便于用户使用

- 有大量的封装函数调用时，Cython的性能最好

- 绑定的对象是C语言写的API或者不涉及面向对象的话，那么用Cython写封装会更方便（不用处理编译的问题）
