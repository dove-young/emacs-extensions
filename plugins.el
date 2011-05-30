


;;;;;;;;;;;;;;;;;;;;;;;;; plugins ;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq dove-init-path "~/.emacs.d/")


;;;;;;;;;;;;;;;;;;;;;;;;; hooks ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;

(setq outline-minor-mode-list 
      (list '(emacs-lisp-mode "(defun\\|(defvar\\|(defcustom\\|(defconst")
	    '(shell-mode ".*[bB]ash.*[#\$] ")
	    '(sh-mode "function .*{")
	    '(perl-mode "sub ")

 ))

(mapc (lambda (mode-name) 
       (add-hook mode-name  'set-outline-minor-mode-regexp t))
      '(shell-mode-hook
        sh-mode-hook
        emacs-lisp-mode-hook
        )
)

(add-hook 'minibuffer-hook (setq blink-matching-paren nil))

(eval-after-load 'shell
  '(progn
 (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
 (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
 t
))

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

(eval-after-load 'w3m
  '(progn
     (define-key w3m-mode-map "h" 'w3m-previous-buffer)
     (define-key w3m-mode-map "l" 'w3m-next-buffer)
     (define-key w3m-mode-map (kbd "C-w") 'w3m-close-window)))

(add-hook 'emacs-lisp-mode-hook 
          (lambda ()
  (local-set-key "\C-cn" (lambda () (interactive) (goto-symbol 'outline-regexp)))
  (local-set-key "\C-cp" (lambda () (interactive) (goto-symbol 'outline-regexp t)))

 ) t )

;(setq emacs-lisp-mode-hook nil)

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

;  (setq cperl-outline-regexp  my-cperl-outline-regexp)
  (setq outline-regexp        cperl-outline-regexp)
  (setq outline-level        'cperl-outline-level)

  (local-set-key "\C-cn" (lambda () (interactive) (goto-symbol 'outline-regexp)))
  (local-set-key "\C-cp" (lambda () (interactive) (goto-symbol 'outline-regexp t)))

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
  '(add-hook 'cperl-mode-hook 'my-cperl-customizations t))

;    (add-to-list 'load-path "~/.emacs.d/el-get/yasnippet")
;    (require 'yasnippet) ;; not yasnippet-bundle

;    (yas/initialize)
;    (yas/load-directory "~/.emacs.d/el-get/yasnippet/snippets")


;(setq emacs-lisp-mode-hook nil)

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

