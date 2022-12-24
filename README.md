# shell_learn
## 学习shell脚本
### 知识点
（1）两个整数之间比较<br/>
-eq 等于（equal） -ne 不等于（not equal）<br/>
-lt 小于（less than） -le 小于等于（less equal）<br/>
-gt 大于（greater than） -ge 大于等于（greater equal）<br/>
注：如果是字符串之间的比较 ，用等号“=”判断相等；用“!=”判断不等。<br/>
（2）按照文件权限进行判断<br/>
-r 有读的权限（read）<br/>
-w 有写的权限（write）<br/>
-x 有执行的权限（execute）<br/>
（3）按照文件类型进行判断<br/>
-e 文件存在（existence）<br/>
-f 文件存在并且是一个常规的文件（file）<br/>
-d 文件存在并且是一个目录（directory）<br/>