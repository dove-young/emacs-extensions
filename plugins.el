


;;;;;;;;;;;;;;;;;;;;;;;;; plugins ;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq dove-init-path "~/.emacs.d/")

; (action-to-list (lambda(p) (add-to-list 'load-path (concat dove-init-path p "/")))
;                  (list
;                   "bbdb"
;                   "switch-window"
;                   "gnuplot"
;                   "muse-mode"
; ;                  "icicles.git/icicles"
;                   )
; )

(action-to-list 'require 
                 (list
                  'tabbar
                  'session)
)

;(require 'icicles)



;; So the idea is that you copy/paste this code into your *scratch* buffer,
;; hit C-j, and you have a working el-get.
(unless (require 'el-get nil t)
 (url-retrieve
  "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
  (lambda (s)
    (end-of-buffer)
    (eval-print-last-sexp))))
 
(require 'el-get)

(setq
  el-get-sources
  '(el-get
    auto-complete
    browse-kill-ring
    buffer-move
;    crontab-mode
;    csv-mode
    psvn
    switch-window
    yasnippet
    emacs-w3m
;
    (:name move-text
           :type emacswiki
           :features move-text)
;    (:name orgmode
;           :type git
;           :url  "git://orgmode.org/org-mode.git"
;           :build ("make")
;           :load-path ("./lisp")
;           :features org-install)
    (:name orgmode
           :type http-tar
           :url "file:///home/dove/.emacs.d/org-7.5.tar.gz"
;           :url "file://localhost/home/dove/.emacs.d/org-7.5.tar.gz"
           :options ("xzf")
           :info "./org-7.5/doc"
           :build ("cd ./org-7.5; make")
           :load-path ("./org-7.5/lisp")
           :features org-install)

    (:name haskell-mode
         :type http-tar
         :options ("xzf")
         :url "file:///home/dove/.emacs.d/haskell-mode-2.8.0.tar.gz"
;         :url "http://projects.haskell.org/haskellmode-emacs/haskell-mode-2.8.0.tar.gz"
         :load "haskell-site-file.el"
         :after (lambda ()
                  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
                  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)))
        (:name oddmuse                  ; the mode used to edit Emacswiki pages
           :type emacswiki
           :features oddmuse
           :after (lambda () (setq oddmuse-username "DavidYoung"))
           )

    (:name Emacs-PDE
           :type http-tar
           :url "file:///home/dove/.emacs.d/Emacs-PDE-0.2.16.tar.gz"
           :options ("xzf")
           :info "./lisp/doc"
           :build ("sed -i -e '/(global-set-key/d' lisp/pde-load.el" "perl Makefile.PL" "make")
           :load-path ("./lisp")
           :features pde-load)        
    (:name icicles
           :type git
           :url "git://github.com/emacsmirror/icicles.git"
           :features icicles
           :after (lambda() (icy-mode))
           )

))

;(el-get 'sync)
(el-get)


;;;;;;;;;;;;;;;;;;;;;;;;; hooks ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;


(setq outline-minor-mode-list 
      (list '(emacs-lisp-mode "(defun")
	    '(shell-mode ".*[bB]ash.*[#\$] ")
	    '(sh-mode "function .*{")
	    '(perl-mode "sub ")
;	    '(cperl-mode "sub ")

 ))

(add-hook 'minibuffer-hook (setq blink-matching-paren nil))
(eval-after-load 'shell
  '(progn
 (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
 t
))

(add-hook 'shell-mode-hook 'set-outline-minor-mode-regexp t )

(add-hook 'sh-mode-hook 'set-outline-minor-mode-regexp t )

(add-hook 'emacs-lisp-mode-hook 'set-outline-minor-mode-regexp  t)

(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key icicle-mode-map (kbd "C-c '") 'org-edit-special)))

(add-hook 'lisp-mode-hook
	  (lambda ()
	    (define-key icicle-mode-map (kbd "C-c '") 'org-edit-src-exit)))

(add-hook 'after-init-hook 'session-initialize)

(add-hook 'latex-mode-hook
	  (lambda()
            (local-set-key "{" 'skeleton-pair-insert-maybe)))

(add-hook 'hs-minor-mode-hook
  '(lambda ()
     (setq hs-minor-mode t)
     (define-key hs-minor-mode-map (quote[f8]) (quote hs-hide-block))
     (define-key hs-minor-mode-map (quote[(shift f8)]) (quote hs-show-block))
))

(setq outline-minor-mode-list 
      (list '(emacs-lisp-mode "(defun")
	    '(shell-mode ".*[bB]ash.*[#\$] ")
	    '(sh-mode "function .*{")
	    '(perl-mode "sub ")
;	    '(cperl-mode "sub ")

 ))

(add-hook 'minibuffer-hook (setq blink-matching-paren nil))
(eval-after-load 'shell
  '(progn
 (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
 t
))

(add-hook 'shell-mode-hook 'set-outline-minor-mode-regexp t )

(add-hook 'sh-mode-hook 'set-outline-minor-mode-regexp t )


(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key icicle-mode-map (kbd "C-c '") 'org-edit-special)))

(add-hook 'lisp-mode-hook
	  (lambda ()
	    (define-key icicle-mode-map (kbd "C-c '") 'org-edit-src-exit)))

(add-hook 'emacs-lisp-mode-hook 'set-outline-minor-mode-regexp  t)

(add-hook 'after-init-hook 'session-initialize)


(add-hook 'latex-mode-hook
	  (lambda()
            (local-set-key "{" 'skeleton-pair-insert-maybe)))

(add-hook 'hs-minor-mode-hook
  '(lambda ()
     (setq hs-minor-mode t)
     (define-key hs-minor-mode-map (quote[f8]) (quote hs-hide-block))
     (define-key hs-minor-mode-map (quote[(shift f8)]) (quote hs-show-block))
))

;; WinnerMode

(when (fboundp 'winner-mode)
  (winner-mode)
  (windmove-default-keybindings))

;; Dictionary
;(load "dictionary-init")
;(setq dictionary-use-single-buffer t)
(load-library "hideshow")
;(ido-mode t)
;     (load "auctex.el" nil t t)
;     (load "preview-latex.el" nil t t)

;(oddmuse-mode-initialize)

    (when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))


;(load "pde-load")

(defun my-cperl-customizations ()
  "cperl-mode customizations that must be done after cperl-mode loads"
  (outline-minor-mode)
  (abbrev-mode)

  (defun cperl-outline-level ()
    (looking-at outline-regexp)
    (let ((match (match-string 1)))
      (cond
       ((eq match "=head1" ) 1)
       ((eq match "package") 2)
       ((eq match "=head2" ) 3)
       ((eq match "=item"  ) 4)
       ((eq match "sub"    ) 5)
       (t 7)
       )))

  (setq cperl-outline-regexp  my-cperl-outline-regexp)
  (setq outline-regexp        cperl-outline-regexp)
  (setq outline-level        'cperl-outline-level)

    (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-j" 'newline)
  (local-set-key (kbd "M-'") 'just-one-space)
  (local-set-key (kbd "C-M-=") 'pde-indent-dwim)
  ;; nearest key to dabbrev-expand
  (local-set-key (kbd "M-;") 'hippie-expand)
  (local-set-key (kbd "C-;") 'comment-dwim)
  (local-set-key "\C-cf" 'comint-dynamic-complete)
;  (local-set-key "\C-cs" 'compile-dwim-compile)
  (local-set-key "\C-cr" 'compile-dwim-run)
  (local-set-key "\C-ci" 'imenu)
  (local-set-key "\C-cv" 'imenu-tree)
  (local-set-key "\C-cj" 'ffap)
  (local-set-key "\C-ch" 'help-dwim)
  (local-set-key "\C-xan" 'tempo-forward-mark)
  (local-set-key "\C-xap" 'tempo-backward-mark)
  (local-set-key "\C-xam" 'tempo-complete-tag)
  (local-set-key " " 'tempo-x-space)  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-j" 'newline)
  (local-set-key (kbd "M-'") 'just-one-space)
  (local-set-key (kbd "C-M-=") 'pde-indent-dwim)
  ;; nearest key to dabbrev-expand
  (local-set-key (kbd "M-;") 'hippie-expand)
  (local-set-key (kbd "C-;") 'comment-dwim)
  (local-set-key "\C-cf" 'comint-dynamic-complete)
  (local-set-key "\C-cs" 'compile-dwim-compile)
  (local-set-key "\C-cr" 'compile-dwim-run)
  (local-set-key "\C-ci" 'imenu)
  (local-set-key "\C-cv" 'imenu-tree)
  (local-set-key "\C-cj" 'ffap)
  (local-set-key "\C-ch" 'help-dwim)
  (local-set-key "\C-xan" 'tempo-forward-mark)
  (local-set-key "\C-xap" 'tempo-backward-mark)
  (local-set-key "\C-xam" 'tempo-complete-tag)
  (local-set-key " " 'tempo-x-space)
)

(eval-after-load 'pde-load
  '(add-hook 'cperl-mode-hook 'my-cperl-customizations))

;    (add-to-list 'load-path "~/.emacs.d/el-get/yasnippet")
;    (require 'yasnippet) ;; not yasnippet-bundle

;    (yas/initialize)
;    (yas/load-directory "~/.emacs.d/el-get/yasnippet/snippets")

(eval-after-load 'w3m
  '(progn
     (define-key w3m-mode-map "h" 'w3m-previous-buffer)
     (define-key w3m-mode-map "l" 'w3m-next-buffer)
     (define-key w3m-mode-map (kbd "C-w") 'w3m-close-window)))

(add-hook 'oddmuse-mode-hook
          (lambda ()
            (unless (string-match "question" oddmuse-post)
              (when (string-match "EmacsWiki" oddmuse-wiki)
                (setq oddmuse-post (concat "uihnscuskc=1;" oddmuse-post)))
              (when (string-match "OddmuseWiki" oddmuse-wiki)
                (setq oddmuse-post (concat "ham=1;" oddmuse-post))))))

;; This function was copied from internet
(defun renumber-list (start end &optional num)
      "Renumber the list items in the current START..END region.
    If optional prefix arg NUM is given, start numbering from that number
    instead of 1."
      (interactive "*r\np")
      (save-excursion
        (goto-char start)
        (setq num (or num 1))
        (save-match-data
          (while (re-search-forward "^[0-9]+" end t)
            (replace-match (number-to-string num))
            (setq num (1+ num))))))
;; This function was copied from internet
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
;  (setq zmacs-region-stays t)
  (point-to-register 8))
;; This function was copied from internet
(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
;  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))


;; ====================================================================
;; ==================== 99 bottle of beers ============================
;; ====================================================================

; The following code is copied from http://99-bottles-of-beer.net/
; I just love it. 

(defun beer-text (num &optional capitalise)
  "Returns a phrase for the given number of bottles of beer.
The phrase is colour-coded red if there are no bottles left or
blue otherwise. If the optional argument CAPITALISE is non-nil,
the first letter of the phrase is capitalised."
  (propertize (cond ((= num 0) (concat (if capitalise "N" "n")
				       "o more bottles of beer"))
		    ((= num 1) "1 bottle of beer")
		    (t         (format "%i bottles of beer" num)))
	      'face (list :foreground (if (equal num 0) "red" "blue"))))

(defun beer-verse (num)
  "Returns a complete verse for the given number of bottles."
  (concat (beer-text num t) " on the wall, "
	  (beer-text num) ".\n"
	  (if (equal num 0)
	      (concat "Go to the store and buy some more, "
		      (beer-text 99) " on the wall.\n")
	    (concat "Take one down and pass it around, "
		    (beer-text (1- num)) " on the wall.\n"))))

(defun beer-song-insert (start)
  "Inserts the complete 99 bottles of beer song into the buffer."
  (let ((n start))
    (while (>= n 0)
      (insert (beer-verse n))
      (when (>= (setq n (1- n)) 0)
	(insert "\n")))))

(defun beer-song (start)
  "Show the 99 bottles of beer song.
The song is created in a buffer called *Beer song* and the buffer
is displayed. If a prefix is given, the song is started from that
number of bottles, otherwise it starts from 99."
  (interactive "P")
  (let ((buf (get-buffer-create "*Beer song*")))
    (with-current-buffer buf
      (kill-all-local-variables)
      (erase-buffer)
      (beer-song-insert (if start (prefix-numeric-value start) 99))
      (goto-char (point-min)))
    (view-buffer buf)))


    (defun find-next-occurance-of-region (start end)
      "Jump to the next occurance of region, and sets it as the current region"
      (interactive "r")
      (let ((region-size (- end start)) (region-text (buffer-substring start end)))
        (unless
	    (when (search-forward region-text nil t 1)
	      (setq mark-active nil)
	      (set-mark (- (point) region-size))
	      (setq mark-active t))
          (message "No more occurances of \"%s\" in buffer!" region-text))))

;=============================================================================
;=============================================================================


;(add-to-list 'load-path "~/Shell/config/emacs.el")
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/bbdb")

; (require-extensions 'require
;  (list 
;   'tabbar 
; ;  'switch-window
; ;  'thing-edit
; ;  'second-sel
; ;  'browse-kill-ring+
; ;  'bbdb
; ;  'gnuplot
; ;  'muse-mode
; ;  'ibuffer
; ;  'w3m-load
; ;  'rect-mark
; ;  'ido
; ;  'multi-term
; ;  'lusty-explorer
; ;  'oddmuse
; ;  'emaci
; ;  'move-text
; ;  'uniquify
; ;  'hide-region
; ;  'ede
; ;  'icicles
;   'session
; ;  'el-get
; ))


;           :url "http://www.emacswiki.org/emacs/download/move-text.el")
;    (:name thing-edit
;           :type EmacsWiki
;           :features thing-edit)
;          :url "http://www.emacswiki.org/emacs/thing-edit.el")

;    (:name browse-kill-ring+
;           :type EmacsWiki
;           :features browse-kill-ring+)
; ;          :url "http://www.emacswiki.org/emacs/browse-kill-ring+.el")
;    (:name rect-mark
;           :type EmacsWiki
;           :features rect-mark)
; ;          :url "http://www.emacswiki.org/emacs/rect-mark.el")
;    (:name multi-term
;           :type EmacsWiki
;           :features multi-term)
; ;          :url "http://www.emacswiki.org/emacs/multi-term.el")
;    (:name lusty-explorer
;           :type EmacsWiki
;           :features lusty-explorer)
; ;          :url "http://www.emacswiki.org/emacs/lusty-explorer.el")

 ;          :url "http://www.emacswiki.org/emacs/oddmuse.el")
;   emaci
;    (:name uniquify
;           :type EmacsWiki
;           :features uniquify)
; ;          :url "http://www.emacswiki.org/emacs/uniquify.el")
;    (:name hide-region
;           :type EmacsWiki
;           :features hide-region)
; ;          :url "http://www.emacswiki.org/emacs/hide-region.el")
; ))


;(el-get)
;(el-get 'sync)
;(when window-system
;   (add-to-list 'el-get-sources  'color-theme-tango))

;(require 'move-text)



;; tabbar mode

;(setq tabbar-buffer-list-function 
;
;;(funcall
;      (lambda nil
;	(setq new-list nil)
;	(let (( buffers (buffer-list) ))
;	  (while buffers
;	    (let (( buffer (pop buffers) ))
;	      (unless (string-match "\*" (buffer-name buffer)) 
;		(setq new-list (cons buffer new-list)))
;	      ))
;	  new-list ))
;;      )
;)


;(add-hook 'shell-mode-hook (lambda () (outline-minor-mode 1) (make-local-variable 'outline-regexp)  (setq outline-regexp ".*[bB]ash.*[#\$] ")) t )

;	   (lambda()
;	     (outline-minor-mode 1)
;	     (setq outline-regexp ".*[bB]ash.*[#\$] ")
;	     (set-key-bindings 'local-set-key
;			       (list
;			       '([C-c C-t] 'hide-body)
;			       '([C-c C-a] 'show-all)
;			       '([C-c C-e] 'show-entry)
;			       ))) t)

;		 (local-set-key (kbd "C-c C-t") 'hide-body)
;		 (local-set-key (kbd "C-c C-a") 'show-all)
;		 (local-set-key (kbd "C-c C-e") 'show-entry)
;		 )
;	   t)


;(add-hook 'sh-mode-hook (lambda () (outline-minor-mode 1) (make-local-variable 'outline-regexp) (setq outline-regexp "function .*{")) t )

;	  (lambda()
;	    (outline-minor-mode 1)
;	    (setq outline-regexp "function")
;	    (set-key-bindings 'local-set-key
;			      (list
;			       '([C-c C-t] 'hide-body)
;			       '([C-c C-a] 'show-all)
;			       '([C-c C-e] 'show-entry)
;			       ))) t)

;	    (local-set-key (kbd "C-c C-t") 'hide-body)
;	    (local-set-key (kbd "C-c C-a") 'show-all)
;	    (local-set-key (kbd "C-c C-e") 'show-entry)) t)		    

;(add-hook 'perl-mode-hook 'set-outline-minor-mode-regexp  t)

;(add-hook 'cperl-mode-hook 'outline-minor-mode)

;(add-hook 'cperl-mode-hook (lambda ()
;                             (outline-minor-mode 1)) )

;(setq cperl-mode-hook 'my-cperl-customizations)

;(defun my-cperl-customizations ()
;  "cperl-mode customizations that must be done after cperl-mode loads"
;  (outline-minor-mode)
;)


;    ;; Make locals out of these variables.
;    ;; Add or delete from the vector, redefine the function.
;    ;; Any hook that runs this is instantly updated.
;    (defun vls-set-local-variables ()
;      (let ((locals [column-number-mode 
;                     fill-individual-varying-indent
;                     colon-double-space
;                     hippie-expand-try-functions-list]))
;        (mapc (lambda (x) (make-local-variable x)) locals)))
;    
;    (defun vls-text-mode-hook ()
;      (vls-set-local-variables)
;      (turn-on-auto-fill)
;      (column-number-mode 1)
;      (setq fill-individual-varying-indent t
;            colon-double-space t
;            fill-column 65
;            abbrev-mode t
;            hippie-expand-try-functions-list '(try-expand-dabbrev
;                                               try-expand-line
;                                               try-complete-file-name)))
;    
;    (add-hook 'text-mode-hook 'vls-text-mode-hook)

;(defun dove-perl-pde-mode-hook ()
;  (outline-minor-mode 1))

;(fset 'perl-mode 'cperl-mode)

;(add-hook 'cperl-mode-hook 'dove-perl-pde-mode-hook)
;(add-hook 'cperl-mode-hook 
;          (lambda ()
;            (outline-minor-mode 1)))


;(defadvice pde-perl-mode-hook (after enable-outline () activate) 
;                                     (outline-minor-mode t)
;                                     (message "%s" "this is my advice")
;                                     )

;(ad-activate 'pde-perl-mode-hook)

;(setq cperl-mode-hook nil)
;(add-hook 'cperl-mode-hook
;      '(lambda () (and (setq outline-regexp "sub") (outline-minor-mode +))) )


;	  (lambda()
;	    (outline-minor-mode 1)
;	    (setq outline-regexp "(defun ")
;	    (set-key-bindings 'local-set-key
;			      (list
;			       '([C-c C-t] 'hide-body)
;			       '([C-c C-a] 'show-all)
;			       '([C-c C-e] 'show-entry)
;			       ))) t)

;	    (local-set-key (kbd "C-c C-t") 'hide-body)
;	    (local-set-key (kbd "C-c C-a") 'show-all)
;	    (local-set-key (kbd "C-c C-e") 'show-entry)) t)

;(add-hook 'outline-minor-mode-hook 
;  '(lambda ()
;     (define-key outline-minor-mode-map (quote[f4]) (quote hide-subtree))
;     (define-key outline-minor-mode-map (quote[(shift f4)]) (quote show-children))
;
;     (define-key outline-minor-mode-map (quote[f9]) (quote hide-region-hide))
;     (define-key outline-minor-mode-map (quote[(shift f9)]) (quote hide-region-unhide))
; ))

;(defun factorial(n) 
;  (if (= n 1) 
;      1  
;    (* n (factorial (- n 1)))
;      )
;)

;(message "%d" (factorial 6))



;		 (local-set-key "(" 'skeleton-pair-insert-maybe)
;		 (local-set-key "[" 'skeleton-pair-insert-maybe)
;		 (local-set-key "{" 'skeleton-pair-insert-maybe)


;    (require 'session)


;(load "zeitgeist.el")

