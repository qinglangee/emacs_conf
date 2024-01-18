;; 公共函数  ===========================================
(defun zh-call-interactively (function &rest args)
  "以交互方式调用函数 FUNCTION"
  (let ((current-prefix-arg '-)) ;; 设置prefix 参数为 '-' 
    (apply function args)))
(defun zhname(name)
  "返回 name 对应的链接缩写的全称"
  ;; cdr 返回列表中的第 2 个元素
  (cdr
    (assoc name org-link-abbrev-alist)))
(defun zhdir(abbrev subpath)
  "返回缩写加子路径的全路径"
  (concat (zhname abbrev) subpath))

;; 时间函数 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 计算 n 天的时间
(defun offset_days(n)
  "根据参数 n 计算 n 天之后的时间， n 为负数时是 n 天之前的时间"
  (let* ((time (current-time))
	 (seconds (float-time time))
	 (adjusted-seconds (+ seconds (* n 86400))))
    (seconds-to-time adjusted-seconds))
)

(defun diff_days(before after)
  "计算两个日期之间相差的天数"
  (let* ((time-delta (time-subtract after before)))
    (/ (float-time time-delta) 86400))
)

;; 编辑函数 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;新建一行，不管光标在哪
(defun zh-newline nil
  "open new line belowe current line"
  (interactive)
  (end-of-line)
  (newline))


;;;删除一行
(defun zh-delete-line nil
  "delete the whole line"
  (interactive)
  (beginning-of-line);光标移动到行首
  (push-mark);做个标记
  (beginning-of-line 2);移动到下一行行首
  (kill-region (point) (mark)));光标和标记之间的删掉


(defun zh-del ()
  "删除一行，没有放到 kill ring 中"
  (interactive)
  (delete-line))

(defun zh-lucky-number nil
  "生产今日幸运数字"
  (interactive)
  (let ((n (zh-random-1000)))
    (format "今日幸运数字 %d %d" (zh-random-1000) (random 100001))))

(defun zh-random-1000 ()
  "产生 0-1000 的随机整数"
  (interactive)
  (let ((n 0)(count 0)) 
    (while (and (< n 100) (< count 1000))
      (setq n (random 1001))
      (setq count (1+ count)))
    n))


;; 插入一个 diary 日志标题
(defun zh-insert-diary-title(offset)
  "Insert date with OFFSET days from today."
  (interactive "sOffset (days): ")
  ; 输入为空时默认设置为 1
  (setq offset	(if (string= offset "") 0 (string-to-number offset)))
  ; 根据参数的天数插入对应的时间
  (let* (
	 (in_time (offset_days offset))
	 (liangong_from (encode-time 0 0 0 4 11 2022))
	 (liangong_day (diff_days liangong_from in_time))
	 (jieyan_from (encode-time 0 0 0 4 12 2023))
	 (jieyan_day (diff_days jieyan_from in_time))
	 (daily-str (format "\n\n## daily daily\n%s\n又是没练功的一天 %d 超一年了\n第%d天" (zh-lucky-number) liangong_day jieyan_day))
	 (title-str (zh-title-str in_time 1)))
    (insert (concat title-str daily-str))))
; 



(defun zh-insert-hour-minute nil
  "插入当前的时:分，后跟一个空格"
  (interactive)
  (insert (format-time-string "%H:%M " (current-time))))

(defun zh-title-str (time &optional week)
  "把一个日期转换成标题的形式
time: 要转换的时间
week: 是否有星期的信息，nil 没有，其它值有
"
  (if week
    (format-time-string "*** %Y-%m-%d %a" time)
    (format-time-string "*** %Y-%m-%d" time)))

(defun zh-point-to-title (search_text)
  "把光标停到匹配的标题处"
  (org-shifttab)       ; 整体折叠
  (beginning-of-buffer); 光标移到开头
  (search-forward search_text nil t) ; 查找符合内容的位置
  (org-cycle))

(defun zh-point-to-orders nil
  "把光标停到未完成的单子处"
  (interactive)
  (zh-point-to-title "*** 正在做"))

(defun zh-point-to-today nil
  "把光标停到当天日期处"
  (interactive)
  (org-shifttab)       ; 整体折叠
  (beginning-of-buffer); 光标移到开头
  (let* ((i 0)
	 (found nil))
    (while (and (> i -100) (not found)) ; 循环查找对应的日期, 最多 100 次
      (let ((date-str (zh-title-str (offset_days i))))
	(when (search-forward date-str nil t) ; 找到就跳出循环
	  (setq found t)))
      (setq i (- i 1)))
    (org-cycle)))      ; 执行一轮 org-cycle

(defun zh-open-note-notwork--- ()
  "在指定目录 DIR 中打开文件, 默认是 notes 目录"
  (interactive)
  (let ((default-directory "d:/eachcloud/nut/nutsb/notes/")) ;; 设置默认目录
    (zh-call-interactively 'find-file))) ;; 调用 find-file

(defun zh-open-note ()
  "在指定目录 DIR 中打开文件, 默认是 notes 目录"
  (interactive)
  (let ((default-directory "d:/eachcloud/nut/nutsb/notes/")) ;; 设置默认目录
    (ido-find-file))) ;; 调用 find-file

(defun find-file-in-documents ()
  "Find a file in ~/Documents/ directory."
  (interactive)
  (let ((default-directory "~/Documents/")) ; set the default directory to the specified one
    (ido-find-file))) ; open a file using ido interface

