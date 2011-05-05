

(setq outline-minor-mode-list 
      (list '(emacs-lisp-mode "(defun")
	    '(shell-mode ".*[bB]ash.*[#\$] ")
	    '(sh-mode "function .*{")
	    '(perl-mode "sub ")
;	    '(cperl-mode "sub ")

 ))

;;;;;;;;;;;;;;;;;;;;;;;;; plugins ;;;;;;;;;;;;;;;;;;;;;;;;;;

;(add-to-list 'load-path "~/Shell/config/emacs.el")
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/bbdb")

(require-extensions 'require
 (list 
  'tabbar 
;  'switch-window
;  'thing-edit
;  'second-sel
;  'browse-kill-ring+
;  'bbdb
;  'gnuplot
;  'muse-mode
;  'ibuffer
;  'w3m-load
;  'rect-mark
;  'ido
;  'multi-term
;  'lusty-explorer
;  'oddmuse
;  'emaci
;  'move-text
;  'uniquify
;  'hide-region
;  'ede
  'icicles
  'session
;  'el-get
))


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
    crontab-mode
    csv-mode
    psvn
    switch-window
    yasnippet
    emacs-w3m

    (:name move-text
           :type emacswiki
           :features move-text)
))

(el-get)

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
;    (:name oddmuse
;           :type EmacsWiki
;           :features oddmuse)
; ;          :url "http://www.emacswiki.org/emacs/oddmuse.el")
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

(bbdb-initialize)
(global-visual-line-mode 1)
(tabbar-mode)
;(icy-mode 1)
(read-abbrev-file "~/.abbrev_defs")
(mouse-avoidance-mode 'jump)
(auto-image-file-mode)
(show-paren-mode t)
(add-hook 'minibuffer-hook (setq blink-matching-paren nil))


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


;; WinnerMode

(when (fboundp 'winner-mode)
  (winner-mode)
  (windmove-default-keybindings))

;; Dictionary
;(load "dictionary-init")
;(setq dictionary-use-single-buffer t)
(display-time)
(load-library "hideshow")
;(ido-mode t)
;     (load "auctex.el" nil t t)
;     (load "preview-latex.el" nil t t)

;(oddmuse-mode-initialize)

    (when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

(eval-after-load 'shell
  '(progn
 (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
 t
))


 (add-hook 'shell-mode-hook 'set-outline-minor-mode-regexp t )

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

(add-hook 'sh-mode-hook 'set-outline-minor-mode-regexp t )
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

(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key icicle-mode-map (kbd "C-c '") 'org-edit-special)))

(add-hook 'lisp-mode-hook
	  (lambda ()
	    (define-key icicle-mode-map (kbd "C-c '") 'org-edit-src-exit)))

(add-hook 'emacs-lisp-mode-hook 'set-outline-minor-mode-regexp  t)

(add-hook 'perl-mode-hook 'set-outline-minor-mode-regexp  t)

;(add-hook 'cperl-mode-hook (lambda ()
;                             (outline-minor-mode 1)) )

(setq cperl-mode-hook 'my-cperl-customizations)

(defun my-cperl-customizations ()
  "cperl-mode customizations that must be done after cperl-mode loads"
  (outline-minor-mode)
)

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

(add-hook 'latex-mode-hook
	  (lambda()
	    		 (local-set-key "{" 'skeleton-pair-insert-maybe)))

;(add-hook 'outline-minor-mode-hook 
;  '(lambda ()
;     (define-key outline-minor-mode-map (quote[f4]) (quote hide-subtree))
;     (define-key outline-minor-mode-map (quote[(shift f4)]) (quote show-children))
;
;     (define-key outline-minor-mode-map (quote[f9]) (quote hide-region-hide))
;     (define-key outline-minor-mode-map (quote[(shift f9)]) (quote hide-region-unhide))
; ))

(add-hook 'hs-minor-mode-hook
  '(lambda ()
     (setq hs-minor-mode t)
     (define-key hs-minor-mode-map (quote[f8]) (quote hs-hide-block))
     (define-key hs-minor-mode-map (quote[(shift f8)]) (quote hs-show-block))
))

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

;(defun factorial(n) 
;  (if (= n 1) 
;      1  
;    (* n (factorial (- n 1)))
;      )
;)

;(message "%d" (factorial 6))


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


;		 (local-set-key "(" 'skeleton-pair-insert-maybe)
;		 (local-set-key "[" 'skeleton-pair-insert-maybe)
;		 (local-set-key "{" 'skeleton-pair-insert-maybe)


;    (require 'session)
    (add-hook 'after-init-hook 'session-initialize)

;(load "zeitgeist.el")

;    (add-to-list 'load-path "~/.emacs.d/el-get/yasnippet")
;    (require 'yasnippet) ;; not yasnippet-bundle

;    (yas/initialize)
;    (yas/load-directory "~/.emacs.d/el-get/yasnippet/snippets")

(load "pde-load")