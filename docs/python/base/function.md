## 默认参数

```Python
def printinfo(name, age=35):
   """打印任何传入的字符串"""
   print( "Name: ", name )
   print( "Age ", age )
 
#调用printinfo函数
printinfo( age=50, name="miki" )
printinfo( name="miki" )
```



## 为函数提供说明文档

其实，函数的说明文档，本质就是一段字符串，只不过作为说明文档，字符串的放置位置是有讲究的，函数的说明文档通常位于函数内部、所有代码的最前面。

```Python
#定义一个比较字符串大小的函数
def str_max(str1,str2):
    '''
    比较 2 个字符串的大小
    '''
    str = str1 if str1 > str2 else str2
    return str
help(str_max)
#print(str_max.__doc__)
```



## 返回多个值

方法1：用元组

  在Python中，元组是以逗号分隔的项目序列；它是一系列不可变的Python对象。

  元组与列表相似，但元组一旦声明就无法更改（元组是不可变的）。

  元组通常比列表更快。

```Python
def fun():
    test_str = 'hello'
    x = 20
    return test_str, x
    
test_str, x = fun() # Assign returned tuple
print( test_str )
print( x )
```



方法2：用字典

  在Python中，字典类似于其他语言中的散列或映射。

  它由键值对组成；可以通过字典中的唯一键访问该值。

```Python
def fun():
    d = dict()
    d['name'] = 'Jack Ma'
    d['age'] = 18
    return d
    
d = fun()
print( d )
```



方法3：用列表

  在Python中，列表就像使用方括号创建的项目数组，它们是可变的。

  它们与数组不同，因为它们可以包含不同类型的项目。

```Python
def fun():
    test_str = 'hello'
    x = 18
    return [test_str, x]
   
test_list = fun()
print( test_list )
```



方法4：用类

  以创建一个类来保存多个值并返回该类的对象。

```Python
class Test:
    def __init__(self):
        self.test_str = 'hello world'
        self.x = 18
        
def fun():
    return Test()
    
t = fun()
print( t.test_str )
print( t.x )
```



## 传入多个值

在python自定义函数中，如果需要传入的实际参数有多个，我们在定义形式参数的时候，可以有两种形式，一是\*args，二是\*\*kwargs。

这两种分别提供了传入的参数是多个的形式。


*args

  这种形式表示接收任意多个实际参数并将其放到一个元组中，类似于传递地址的形式，将多个数据一次性传入。

```Python
def printcoff(*args):
  for item in args:
    print(item)
    
printcoff("karl","inter","killer")
plist = [1,2,3,4,5,6,7,8,9,0]
printcoff(*plist)
```

  这样实现的好处在于，我们可以将自定义函数，实现输入的列表分别存放，如果需要改变列表，不改变功能，只要将列表内容更新即可。

  同时，如果配合文件操作，可以通过函数实现办公的自动化操作。

**kwargs形式

  这种形式表示接受任意多个类似关键字参数一样显示赋值的实际参数，并将其放到一个字典中。

```Python
def printcoff(**kwargs):
  for key, value in kwargs.items():
    print(key, value)
    
pdict = {"1":"karl","2":"inter","3":"killer","4":"python"}
printcoff(**pdict)

```



args类型是一个tuple，而kwargs则是一个字典dict，并且args只能位于kwargs的前面。

```Python
def test_kwargs(first, *args, **kwargs):
   print(f'Required argument: {first}')
   print(type(kwargs))
   for v in args:
      print(f'Optional argument (args): {v}')
   for k, v in kwargs.items():
      print(f'Optional argument {k} (kwargs): {v}')

test_kwargs(1, 2, 3, 4, k1=5, k2=6)
```



## lambda表达式

lambda 表达式，又称匿名函数，常用来表示内部仅包含 1 行表达式的函数。

如果一个函数的函数体仅有 1 行表达式，则该函数就可以用 lambda 表达式来代替。

语法：`name = lambda [list] : 表达式`

该语法转换成普通函数形式如下：

```Python
def name(list):
    return 表达式
name(list)
```



例如：

```Python
def add(x, y):
    return x + y
    
print(add(3,4))

add = lambda x, y : x + y
print(add(3,4))

```

可以这样理解 lambda 表达式，其就是简单函数（函数体仅是单行的表达式）的简写版本。

相比函数，lamba 表达式具有以下  2 个优势：  

- 对于单行函数，使用 lambda 表达式可以省去定义函数的过程，让代码更加简洁；
- 对于不需要多次复用的函数，使用 lambda 表达式可以在用完之后立即释放，提高程序执行的性能。