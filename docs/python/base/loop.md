## for循环

```python
for i in range(10):
    print(i)

for x in range(4, 7):
    print(x)

for x in range(4, 20, 2):
    print(x)
```

```python
temp_list = ['one', 'two', 'three', 'four', 'five']
for li in temp_list:
    print(li)
```

```python
temp_list = ['one', 'two', 'three', 'four', 'five']
for li in temp_list:
    print(li) 
    if li == "two":
        break
```

```python
temp_list = ['one', 'two', 'three', 'four', 'five']
for li in temp_list:
    if li == "three":
        continue
    print(li)
```

```python
for x in range(10):
    print(x)
else:
    print("finished")
```

```python
out = ["out_1", "out_2", "out_3"]
inner = ["in_1", "in_2", "in_3"]

for x in out:
    for y in inner:
        print(x, y)
```

## while循环

```python
iterate = 1
threshold = 7
while iterate < threshold:
    print(iterate)
    iterate += 1
```

```python
iterate = 1
threshold = 7
while iterate < threshold:
    if iterate == 4:
        break
    print(iterate)
    iterate += 1
```

```python
iterate = 1
threshold = 7
while iterate < threshold:
    iterate += 1
    if iterate == 4:
        continue
    print(iterate)
```

```python
iterate = 1
threshold = 7
while iterate < threshold:
    print(iterate)
    iterate += 1
else:
    print('iterate is big than threshold')
```