# JSP_SSM_logistics
SSM基于Floyd物流管理系统设计可升级SpringBoot毕业源码案例设计
## 后台框架: SSM(SpringMVC + Spring + Mybatis)
## 前台框架： Bootstrap(一个HTML5响应式框架）
## 开发环境：myEclipse/eclipse/idea + mysql数据库
该系统实现了用户的委托订单，以及管理员安排车子进行物流配送等信息。系统分为4个模块，分别是登录模块、用户下单模块、订单配送模块、车辆调度模块。
后台管理界面
### 订单基本信息的管理
管理员对订单信息进行管理，查询和修改
## 注册用户管理
管理员可以对以注册的用户进行停权、授权和删除等操作。
## 订单状态信息管理
管理订单状态，可以给订单状态设置初始值，与订单信息绑定。可以查看订单的随时的状态，便于管理。
## 运输车辆信息的管理
管理员接到用户的运输订单，可以根据车库里面的车辆进行安排。
## 车辆调度信息管理
每个调度会规定车辆物流线路，一个调度可以运输很多用户的订单货物，根据这个调度，管理员可以灵活的，将同一终点的货物加入同一个调度里面，方便运输成本的减少。
新闻动态，新闻动态主要是负责跟用户进行交流的入口，方便告知全体人员，有关公司的任何新的政策以及任何新动态的及时通知。
前台界面
## 1.用户注册和登陆
用户的注册及登陆，不登陆不能委托订单
## 2.我要下单
下单包括入库寄件人信息，收件方信息，以及快递重量。快递物品图片证明。
## 3. 我的订单信息
用户下单寄件后，能在网站上查看我的下单信息，并且可以看到我的订单办理进度，并且还可以查看物流进度，当前快递运送到哪个位置。

用户: 用户名,登录密码,姓名,性别,出生日期,用户照片,联系电话,邮箱,家庭地址,注册时间

用户订单: 订单id,寄件人姓名,寄件人电话,寄件人地址,收件方电话,收件方电话,收件方地址,货物名称,货物照片,货物价格,货物重量,发布用户,订单状态,发布时间

订单状态: 订单状态id,订单状态名称

运输车辆: 车牌号,车辆照片,车辆颜色,车架号,吨位,购买日期,驾驶员姓名,驾驶员身份证,驾驶员电话,车辆状态,备注信息

车辆调度: 调度id,调度车辆,出发地,起点经度,起点纬度,终到地,终点经度,终点纬度,当前位置,出发时间,抵达时间,调度状态,运输成本

订单运输: 运输id,运输订单,加入调度,加入时间,备注

新闻动态: 新闻id,标题,公告内容,发布时间
