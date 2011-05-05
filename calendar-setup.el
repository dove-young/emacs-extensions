;(require 'calendar)
;(require 'cal-china)
;(require 'cal-china-x)
;(require 'cal-move)
;(require 'holidays)
;(require 'solar) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 设置日历 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置日历的一些颜色
;(setq calendar-load-hok
;      '(lambda ()
;         (set-face-foreground 'diary-face "skyblue")
;         (set-face-background 'holiday-face "slate blue")
;         (set-face-foreground 'holiday-face "white")))
;;设置我所在地方的经纬度，calendar里有个功能是日月食的预测，和你的经纬度相联系的。
;; 让emacs能计算日出日落的时间，在 calendar 上用 S 即可看到
(setq calendar-latitude +39.54)
(setq calendar-longitude +116.28)
(setq calendar-location-name "北京")
;; 设置阴历显示，在 calendar 上用 pC 显示阴历
(setq calendar-chinese-celestial-stem
      ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq calendar-chinese-terrestrial-branch
      ["子" "丑" "寅" "卯" "辰" "巳" "戊" "未" "申" "酉" "戌" "亥"])
;; 设置 calendar 的显示
(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 0) ; 设置星期一为每周的第一天
(setq calendar-mark-diary-entries-flag t) ; 标记calendar上有diary的日期
(setq calendar-mark-holidays-flag t) ; 为了突出有diary的日期，calendar上不标记节日
(setq calendar-view-holidays-initially-flag nil) ; 打开calendar的时候不显示一堆节日
;; 去掉不关心的节日，设定自己在意的节日，在 calendar 上用 h 显示节日
(setq holiday-christian-holidays nil)
(setq holiday-hebrew-holidays nil)
(setq holiday-islamic-holidays nil)
(setq holiday-solar-holidays nil)
(setq holiday-general-holidays nil)
(setq holiday-oriental-holidays nil)

(setq calendar-chinese-all-holidays-flag t)
;(setq holiday-other-holidays '(
;(holiday-fixed 9 20 "自己的节日")
;(holiday-fixed 9 22 "中秋节")
;))
(setq holiday-other-holidays 
			'((holiday-fixed 1 1 "元旦")
				(holiday-fixed 2 14 "情人节")
				(holiday-fixed 3 14 "白色情人节")
				(holiday-fixed 4 1 "愚人节")
				(holiday-fixed 5 1 "劳动节")
				(holiday-float 5 0 2 "母亲节")
				(holiday-fixed 6 1 "儿童节")
				(holiday-float 6 0 3 "父亲节")
				(holiday-fixed 7 1 "建党节")
				(holiday-fixed 8 1 "建军节")
				(holiday-fixed 9 10 "教师节")
				(holiday-fixed 10 1 "国庆节")
				(holiday-fixed 12 25 "圣诞节")

))

(setq
			holiday-local-holidays
			'(
				(holiday-chinese 1 1 "春节 (正月初一)")
				(holiday-chinese 1 15 "元宵 (正月十五)")
				(holiday-chinese 2 25 "花朝 (二月十五)")
				(holiday-chinese 2 26 "清明 (三月初三)")
				(holiday-chinese 5 5 "端午 (五月初五)")
				(holiday-chinese 7 7 "七夕 (七月初七)")
				(holiday-chinese 7 15 "中元 (七月十五)")
				(holiday-chinese 8 15 "中秋 (八月十五)")
				(holiday-chinese 9 9 "重阳 (九月初九)")
				(holiday-chinese 12 8 "腊八 (十二月初八)")
				(holiday-chinese 12 24 "小年 (十二月二十四)")
(holiday-fixed 1 5 "小寒")
(holiday-fixed 1 20 "大寒")
(holiday-fixed 2 4 "立春")
(holiday-fixed 2 19 "雨水")
(holiday-fixed 3 6 "驚蟄")
(holiday-fixed 3 21 "春分")
(holiday-fixed 4 5 "清明")
(holiday-fixed 4 20 "榖雨")
(holiday-fixed 5 5 "立夏")
(holiday-fixed 5 21 "小滿")
(holiday-fixed 6 6 "芒種")
(holiday-fixed 6 21 "夏至")
(holiday-fixed 7 7 "小暑")
(holiday-fixed 7 23 "大暑")
(holiday-fixed 8 7 "立秋")
(holiday-fixed 8 23 "處暑")
(holiday-fixed 9 8 "白露")
(holiday-fixed 9 23 "秋分")
(holiday-fixed 10 8 "寒露")
(holiday-fixed 10 23 "霜降")
(holiday-fixed 11 7 "立冬")
(holiday-fixed 11 22 "小雪")
(holiday-fixed 12 7 "大雪")
(holiday-fixed 12 22 "冬至")
				))

;(setq
;holiday-general-holidays nil
;holiday-christian-holidays nil
;holiday-hebrew-holidays nil
;holiday-islamic-holidays nil
;holiday-solar-holidays nil
;holiday-bahai-holidays nil)

;;Calendar模式支持各种方式来更改当前日期
;;（这里的“前”是指还没有到来的那一天，“后”是指已经过去的日子）
;; q 退出calendar模式
;; C-f 让当前日期向前一天
;; C-b 让当前日期向后一天
;; C-n 让当前日期向前一周
;; C-p 让当前日期向后一周
;; M-} 让当前日期向前一个月
;; M-{ 让当前日期向后一个月
;; C-x ] 让当前日期向前一年
;; C-x [ 让当前日期向后一年
;; C-a 移动到当前周的第一天
;; C-e 移动到当前周的最后一天
;; M-a 移动到当前月的第一天
;; M-e 多动到当前月的最后一天
;; M-< 移动到当前年的第一天
;; M-> 移动到当前年的最后一天
;;Calendar模式支持移动多种移动到特珠日期的方式
;; g d 移动到一个特别的日期
;; o 使某个特殊的月分作为中间的月分
;; . 移动到当天的日期
;; p d 显示某一天在一年中的位置，也显示本年度还有多少天。
;; C-c C-l 刷新Calendar窗口
;; Calendar支持生成LATEX代码。
;; t m 按月生成日历
;; t M 按月生成一个美化的日历
;; t d 按当天日期生成一个当天日历
;; t w 1 在一页上生成这个周的日历
;; t w 2 在两页上生成这个周的日历
;; t w 3 生成一个ISO-SYTLE风格的当前周日历
;; t w 4 生成一个从周一开始的当前周日历
;; t y 生成当前年的日历
;;EMACS Calendar支持配置节日：
;; h 显示当前的节日
;; x 定义当天为某个节日
;; u 取消当天已被定义的节日
;; e 显示所有这前后共三个月的节日。
;; M-x holiday 在另外的窗口的显示这前后三个月的节日。
;; 另外，还有一些特殊的，有意思的命令：
;; S 显示当天的日出日落时间(是大写的S)
;; p C 显示农历可以使用
;; g C 使用农历移动日期可以使用
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 日历设置结束 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 设置日记 ;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;
(setq diary-file "~/.diary");; 默认的日记文件
(setq diary-mail-addr "dove.young@gmail.com")
(add-hook 'diary-hook 'appt-make-list)
;;当你创建了一个'~/diary'文件，你就可以使用calendar去查看里面的内容。你可以查看当天的事件，相关命令如下 ：
;; d 显示被选中的日期的所有事件
;; s 显示所有事件，包括过期的，未到期的等等
;; 创建一个事件的样例：
;; 02/11/1989
;; Bill B. visits Princeton today
;; 2pm Cognitive Studies Committee meeting
;; 2:30-5:30 Liz at Lawrenceville
;; 4:00pm Dentist appt
;; 7:30pm Dinner at George's
;; 8:00-10:00pm concert
;; 创建事件的命令：
;; i d 为当天日期添加一个事件
;; i w 为当天周创建一个周事件
;; i m 为当前月创建一个月事件
;; i y 为当前年创建一个年事件
;; i a 为当前日期创建一个周年纪念日
;; i c 创建一个循环的事件
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 设置日记结束 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'calendar-setup)
