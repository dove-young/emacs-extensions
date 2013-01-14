
;(setq x-select-enable-clipboard t)

;(set-frame-width 120)
;; emacs layout
(menu-bar-mode 1)
(tool-bar-mode -1)
;(icomplete-mode 1)
(scroll-bar-mode -1)
;(ruler-mode -1)
(setq system-time-locale "C")

(display-time)
;(bbdb-initialize)
(global-visual-line-mode 1)
(tabbar-mode)
(icy-mode 1)
(read-abbrev-file "~/.abbrev_defs")
(mouse-avoidance-mode 'jump)
(auto-image-file-mode)
(show-paren-mode t)

;; Misc
(setq-default abbrev-mode t
	      line-spacing 4
)

(setq save-abbrevs                                       t
      x-select-enable-clipboard                          t
      inhibit-startup-message                            t
      column-number-mode                                 t
      mark-diary-entries-in-calendar                     t
      display-time-day-and-date                          t
      ido-toggle-regexp                                  t
      kill-do-not-save-duplicates                        t
      appt-issue-message                                 t
      dired-auto-revert-buffer                           t
      speedbar-use-images                                t

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
      multi-term-program                                 "/usr/bin/zsh"
      dim:switch-window-relative                         nil
      shell-file-name                                    "/usr/bin/zsh"
      default-major-mode                                 'text-mode
      cperl-xemacs-p                                     nil
;      dired-isearch-filenames                           dwim
      split-height-threshold                             nil                 ; set split-window horizontally by default
      split-width-threshold                              80 
      scroll-conservatively                              10
      scroll-margin                                      2
      sr-speedbar-width-x                                40
      scroll-margin                                      1
      scroll-conservatively                              10000
      sr-speedbar-width-x                                40
      dired-omit-mode                                    1
      linum-mode                                         1
      magit-repo-dirs-depth                              0
      nxhtml-global-minor-mode                           t
      nxhtml-skip-welcome                                t
      rng-nxml-auto-validate-flag                        nil 
      mumamo-chunk-coloring                              'submode-colored
      indent-region-mode                                 t
      cperl-tags-file-name                               "PDE-TAGS"
      ispell-program-name                                "aspell"
      eshell-where-to-jump                               'begin
      eshell-review-quick-commands                       nil
      eshell-smart-space-goes-to-end                     t
      tramp-default-method                               "ssh"

)

;(setq dired-auto-revert-buffer t)
;(setq ispell-program-name "aspell")
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

(setenv "EMACSSHELL" shell-file-name)

(eval-after-load 'speedbar
  '(progn
     (mapc 'speedbar-add-supported-extension
           '(".sh" ".pl" ".pm" ".txt" ".rb" ".ru"))
     (setq speedbar-frame-parameters '((minibuffer)
                                       (width . 30)
                                       (border-width . 0)
                                       (menu-bar-lines . 0)
                                       (tool-bar-lines . 0)
                                       (unsplittable . t)
                                       (left-fringe . 0)))))

(setq eshell-prompt-function (lambda nil
  (concat
;   (number-to-string 
;    (+ 1 
;       (ring-length eshell-history-ring))) " + "
   (format-time-string "%H:%M:%S")         " + "
   (let ((dir-list
          (split-string ;"~/Shell/branch_dev/agent_team/common" "/")))
           (abbreviate-file-name
            (eshell/pwd)) "/")))
     (if
         (> (length dir-list) 1)
         (concat (car (last (butlast dir-list))) "/" (car (last dir-list)))
       (car dir-list))
     )
   (if
       (=
        (user-uid)
        0)
       " # " " $ "))))

(mapcar (lambda (setting)
          (setq auto-mode-alist (cons setting auto-mode-alist)))
'(("\\.xml$"          . sgml-mode)
  ("\\.bash"          . sh-mode)
  ("\\.rdf$"          . sgml-mode)
  ("\\.session$"      . emacs-lisp-mode)
  ("\\.l$"            . c-mode)
  ("\\.css$"          . css-mode)
  ("\\.cfm$"          . html-mode)
  ("\\.gnus"          . emacs-lisp-mode)
  ("\\.idl$"          . idl-mode)
  ("[^/]\\.dired$"    . dired-virtual-mode)
  ("\\.yml$"          . yaml-mode)))

