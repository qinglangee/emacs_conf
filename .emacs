(column-number-mode t)         ;显示列号
(global-display-line-numbers-mode)   ;列前显示行号
(global-tab-line-mode t)       ;显示 buffer tab
(setq make-backup-files nil)        ;不创建备份文件
; (auto-image-file-mode nil) ;打开图片显示功能

(setq org-image-actual-width '(800)); 设置图片默认显示大小
(setq org-startup-with-inline-images t) ; 让图片在加载 buffer 时就显示


;; 设置一些文件前缀
(setq d_nut "d:\\eachcloud\\nut\\nutsb\\")
(setq emacs_img_folder "d:/workspaces/emacs_img/")
(setq d_soho "d:\\workspaces\\github\\qinglangee\\soho_scripts\\")
(setq java_tpl (concat d_soho "templates\\java\\"))
(setq py_tpl (concat d_soho "templates\\python\\templates\\"))
(setq py_demo (concat d_nut "code\\python\\demo_project\\"))
;; 设置各种链接前缀
(setq org-link-abbrev-alist
      ;;  [`] 开头的列表，内部可以用 [,] 表示对列表进行求值，否则列表不会求值。 如 [,(concat d_nut "abc")]
      `(("nut" . ,d_nut)
	("emacs_img_folder" . ,emacs_img_folder)
	("noteimg" . ,(concat d_nut "notes\\imgs\\"))
        ("java_tpl" . ,java_tpl)
        ("python_templates" . ,py_tpl)
        ("py_tpl" . ,py_tpl)
        ("py_demo" . ,py_demo)))
; 参数是nil,忽略,正数时，启动 CUA, 0和负数时关闭 CUA, 参数是 toggle 时就来回切换
(cua-mode 1) ; CUA 模式，使用C-c v x z 同一般软件那样
(setq org-support-shift-select t) ; select 可以选择内容


;; 开启括号自动匹配模式， 并设置自动匹配的对
(electric-pair-mode 1)
(setq electric-pair-text-pairs '(
                                 ;(34 . 34)
                                 ;(8216 . 8217)
                                 ;(8220 . 8221)
                                 (?\“ . ?\”)
                                 (?\{ . ?\})
                                 (?\《. ?\》)
                                 (?\「. ?\」)
                                 (?\< . ?\>)
                                 (?\【. ?\】)
                                 ))

(fset 'yes-or-no-p 'y-or-n-p)     ;以 y/n代表 yes/no，可能你觉得不需要，呵呵

;; 文件打开方式
(setq org-file-apps
  '((auto-mode . emacs)
   (directory . emacs)
   ("\\.mm\\'" . default)
   ("\\.x?html?\\'" . emacs)
   ("\\.tmpl?\\'" . emacs)
   ("\\.pdf\\'" . default)))

;; 加载 ob-mermaid 插件， 设置 mermaid-cli 命令位置， 下面开启语言时要用
(load-file "~/.emacs.d/private/ob-mermaid-master/ob-mermaid.el")
(setq ob-mermaid-cli-path "e:\\in\\nodejs\\mmdc.cmd")

;;  开启对语言代码执行功能
(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (R . t)
    (dot . t)  ;; dot 需要安装 graphviz, choco install graphviz
    (plantuml .t)
    (mermaid . t)
    (python . t)))

;(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。很好玩阿，这个功能
;(mouse-avoidance-mode 'none);光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。很好玩阿，这个功能

; 设置默认使用 utf8 编码
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)
;(set-selection-coding-system 'utf-8)

;; 设置viper模式
(setq viper-mode t)
(require 'viper)

;; org mode 设置
(setq org-log-done 'time) ; TODO 结束时自动加入时间
;(setq org-log-done 'note) ; TODO 结束时提示加入 note, note 好像是包含了 time
(setq org-agenda-skip-scheduled-if-done t) ; 已经 Done 的 todo 不显示在 agenda 中
(setq org-agenda-skip-scheduled-if-deadline-is-shown t) ; 已经 deadline 了， scheduled 就不用重复显示了


(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)


;; tab color settings
(set-face-attribute 'tab-line nil ;; background behind tabs
      :background "gray40"
      :foreground "gray60" :distant-foreground "#aa0000"
      :height 1.0 :box nil)
(set-face-attribute 'tab-line-tab nil ;; active tab in another window
      :inherit 'tab-line
      :foreground "gray70" :background "gray90" :box nil)
(set-face-attribute 'tab-line-tab-current nil ;; active tab in current window
      :background "#104020" :foreground "white" :box nil) 
(set-face-attribute 'tab-line-tab-inactive nil ;; inactive tab
      :background "gray60" :foreground "black" :box nil)
(set-face-attribute 'tab-line-highlight nil ;; mouseover
      :background "white" :foreground 'unspecified)

;; org src face
(set-face-attribute 'org-block-begin-line nil
  :foreground "#8e3883")


;; melpa-site
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(load-file "~/.emacs.d/emacs_conf/fun_edit.el")
(load-file "~/.emacs.d/emacs_conf/key-bind.el")
(load-file "~/.emacs.d/emacs_conf/open_files.el")

;; org roam
(setq org-roam-directory (concat (zhname "nut") "org_roam"))
(org-roam-db-autosync-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(org-agenda-files '("d:/eachcloud/我的坚果云/nutsb/record/diary/2023.org"))
 '(package-selected-packages '(markdown-mode org-roam)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; 设置字体和字体大小
(set-fontset-font "fontset-default"
		  'han '("Microsoft YaHei" . "unicode-bmp"))
;(set-face-attribute 'font nil :height 200 :width 'normal)
;(set-face-attribute 'default nil :height 200 :width 'normal)
(set-face-attribute 'default nil :height 120)

;; session
(desktop-save-mode nil)
