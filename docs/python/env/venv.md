# venv

venv是python官方自带的虚拟环境，强烈推荐使用

## 固定虚拟环境位置

虚拟环境的位置选择有两种方案：

1.确定一个全局位置，以后所有的虚拟环境全部放到这里来

windows就放在`D:/softenv/pyenvs/`中

Mac/Linux就放在`/Users/xxx/pyenvs/`中

2.将虚拟环境放到你的项目目录下，约定俗成的命名为venv

## VSCode配置

在vscode中的settings.json中添加如下配置

```json
"python.venvPath": "/Users/kxz/pyenvs", // 这里是你的虚拟环境存放位置
"python.venvFolders": [
    ".jupyter", // 这里是你的虚拟环境名称，也就是文件名
],
```

## 创建虚拟环境

```bash
python3 -m venv /path/to/myenv 
```

## 激活虚拟环境

<table>
    <thead>
        <tr>
            <th>Platform</th>
            <th>Shell</th>
            <th>Command to activate virtual environment</th>
        </tr>
    </thead>
    <tbody>
        <tr class="row-even">
            <td rowspan="4" style="center">POSIX</td>
            <td>bash/zsh</td>
            <td>source &nbsp;venv/bin/activate</td>
        </tr>
        <tr class="row-odd">
            <td>fish</td>
            <td>source &nbsp;venv/bin/activate.fish</td>
        </tr>
        <tr class="row-even">
            <td>csh/tcsh</td>
            <td>source &nbsp;venv/bin/activate.csh</td>
        </tr>
        <tr class="row-odd">
            <td>PowerShell</td>
            <td>venv/bin/Activate.ps1</td>
        </tr>
        <tr class="row-even">
            <td rowspan="2">Windows</td>
            <td>cmd.exe</td>
            <td>C:\> venv\Scripts\activate.bat</td>
        </tr>
        <tr class="row-odd">
            <td>PowerShell</td>
            <td>PS C:\> venv\Scripts\Activate.ps1</td>
        </tr>
    </tbody>
</table>

## 退出虚拟环境

```bash
deactivate
```


## 删除虚拟环境

直接在`D:/softenv/pyenvs/`中或`/Users/xxx/pyenvs/`中将虚拟环境的文件夹手动删除即可，如果在vscode的settings.json中配置了，则手动剔除环境。

## requirements.txt

```bash
(venv) $ pip freeze > requirements.txt
(venv) $ pip install -r requirements.txt
```

