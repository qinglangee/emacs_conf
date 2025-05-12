;; 设置全局快捷键
(global-set-key (kbd "C-x k") 'kill-this-buffer)
; windows 常用设置
;(keymap-global-set "C-z" 'undo)

;; 设置自定义前缀键
(define-prefix-command 'meta-j-map) ;; 增加一个 prefix
(global-set-key (kbd "M-j") 'meta-j-map)  ;; prefix 绑定到 M-j 键上

;; 自定义函数绑定
(global-set-key [S-return] 'zh-newline);绑定Shift-回车
(global-set-key (kbd "M-j M-t") (lambda () (interactive) (call-interactively 'zh-insert-diary-title)))  ;; 插入一个日志标题  
(global-set-key (kbd "M-j M-y") 'zh-insert-hour-minute)   ;; 插入当前时间
(global-set-key (kbd "M-d") 'zh-delete-line);删除一行
(keymap-global-set "M-j M-h" 'zh-point-to-today);  定位到今天的流水帐
(keymap-global-set "M-j M-k" 'zh-point-to-orders);  定位到未完成单子
(keymap-global-set "C-c o" 'zh-open-note); 打开 notes 目录中的文件 


;; 系统功能绑定
(keymap-global-set "M-j M-j" 'org-show-todo-tree);  显示当前文件中的未完成 TODOf
(global-set-key (kbd "C-c i w") 'toggle-word-wrap)  ;; 切换折行
(keymap-global-set "C-c <down>" 'duplicate-line) ; 复制一行


; 设置 org mode  快捷键
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

; 快捷键设置
; C-s 本来是 isearch-forward, 这个可以用 C-x C-s 也可以 vim 模式用 / 查询
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-x C-s") 'isearch-forward)

