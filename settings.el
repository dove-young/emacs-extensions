
;(setq x-select-enable-clipboard t)

;(set-frame-width 120)
;; emacs layout
(menu-bar-mode 1)
(tool-bar-mode -1)
(icomplete-mode 1)
(scroll-bar-mode -1)
;(ruler-mode -1)
(setq system-time-locale "C")

(display-time)
;(bbdb-initialize)
(global-visual-line-mode 1)
;(tabbar-mode)
;(icy-mode 1)
(read-abbrev-file "~/.abbrev_defs")
(mouse-avoidance-mode 'jump)
(auto-image-file-mode)
(show-paren-mode t)


(setq save-abbrevs                                       t
      x-select-enable-clipboard                          t
      inhibit-startup-message                            t
      column-number-mode                                 t
      mark-diary-entries-in-calendar                     t
      display-time-day-and-date                          t
      ido-toggle-regexp                                  t
      kill-do-not-save-duplicates                        t
      appt-issue-message                                 t
      show-paren-style                                   'mixed
      default-fill-column                                100
      uniquify-buffer-name-style                         'forward
      ispell-dictionary                                  "english"
      frame-title-format                                 "%b %n %I"
      paragraph-start                                    "\\*\\|$" 
      paragraph-separate                                 "$"
      todo-file-do                                       "~/todo/do"
      todo-file-done                                     "~/todo/done"
      todo-file-top                                      "~/todo/top"
      calendar-latitude                                  +39.54
      calendar-longitude                                 +116.23
      calendar-location-name                             "Beijing"
      ibuffer-default-sorting-mode                       'major-mode
      multi-term-program                                 "/bin/bash"
      dim:switch-window-relative                         nil
      shell-file-name                                    "/bin/bash"
      default-major-mode                                 'text-mode
      cperl-xemacs-p                                     nil
;      dired-isearch-filenames                           dwim
)

(setq dired-auto-revert-buffer t)

; hippie mode remember an anchor then jump back
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))


;; Misc
(setq-default abbrev-mode t
	      line-spacing 4
)

(setenv "EMACSSHELL" shell-file-name)

(setq speedbar-use-images t)

(eval-after-load 'speedbar
  '(progn
     (speedbar-add-supported-extension ".sh")
     (speedbar-add-supported-extension ".pl")
     (speedbar-add-supported-extension ".pm")
     (speedbar-add-supported-extension ".txt")
     (setq speedbar-frame-parameters '((minibuffer)
                                       (width . 30)
                                       (border-width . 0)
                                       (menu-bar-lines . 0)
                                       (tool-bar-lines . 0)
                                       (unsplittable . t)
                                       (left-fringe . 0)))
     ))
  
; http://www.emacswiki.org/emacs-zh/FillParagraph

 ;(setq paragraph-start "\\*\\|$" 
;          paragraph-separate "$")
; http://www.emacswiki.org/emacs-zh/AutoFillMode
;;    (add-hook 'text-mode-hook
;;              (lambda ()
;;                (when (y-or-n-p "Auto Fill mode? ")
;;                  (turn-on-auto-fill))))


