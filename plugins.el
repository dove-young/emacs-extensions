


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
     (add-hook 'w3m-mode-hook (lambda ()
               (define-key w3m-mode-map "e" (lambda nil (interactive) (w3m-scroll-up-1 (/ (window-height) 2))))  
                                        ; (w3m-linknum-edit-this-url)
               (define-key w3m-mode-map "o" (lambda nil (interactive) (w3m-scroll-up-1 (- 0 (/ (window-height) 2)))))
               (define-key w3m-mode-map "h" 'w3m-previous-buffer)
               (define-key w3m-mode-map "l" 'w3m-next-buffer)
               (define-key w3m-mode-map "l" 'w3m-next-buffer)
               (define-key w3m-mode-map (kbd "C-w") 'w3m-close-window)))))

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

(add-hook 'view-mode-hook
          (lambda ()
            (define-key view-mode-map "o" (lambda nil (interactive) (View-scroll-line-backward (/ (window-height) 2))) )
            (define-key view-mode-map "e" (lambda nil (interactive) (View-scroll-line-forward  (/ (window-height) 2))) )
            (define-key view-mode-map "j" 'View-scroll-page-forward)
            (define-key view-mode-map "k" 'View-scroll-page-backward)
))

(eval-after-load "icicles-opt.el"
 (add-hook 'icicle-mode-hook
          (lambda ()
             (setq my-icicle-top-level-key-bindings
                     (mapcar (lambda (lst)
                               (unless (string= "icicle-occur" (nth 1 lst)) lst))
                              icicle-top-level-key-bindings))
                    (setq icicle-top-level-key-bindings my-icicle-top-level-key-bindings) )))

(icy-mode)
;)

; (setq view-mode-hook nil)
; o was bound to (View-scroll-to-buffer-end)
; e was bound to (View-exit)
;
;;; Define keymap inside defvar to make it easier to load changes.
;;; Some redundant "less"-like key bindings below have been commented out.
;(defvar view-mode-map
;  (let ((map (make-sparse-keymap)))
;    (define-key map "C" 'View-kill-and-leave)
;    (define-key map "c" 'View-leave)
;    (define-key map "Q" 'View-quit-all)
;    (define-key map "E" 'View-exit-and-edit)
;    ;; (define-key map "v" 'View-exit)
;    (define-key map "e" 'View-exit)
;    (define-key map "q" 'View-quit)
;    ;; (define-key map "N" 'View-search-last-regexp-backward)
;    (define-key map "p" 'View-search-last-regexp-backward)
;    (define-key map "n" 'View-search-last-regexp-forward)
;    ;; (define-key map "?" 'View-search-regexp-backward) ; Less does this.
;    (define-key map "\\" 'View-search-regexp-backward)
;    (define-key map "/" 'View-search-regexp-forward)
;    (define-key map "r" 'isearch-backward)
;    (define-key map "s" 'isearch-forward)
;    (define-key map "m" 'point-to-register)
;    (define-key map "'" 'register-to-point)
;    (define-key map "x" 'exchange-point-and-mark)
;    (define-key map "@" 'View-back-to-mark)
;    (define-key map "." 'set-mark-command)
;    (define-key map "%" 'View-goto-percent)
;    ;; (define-key map "G" 'View-goto-line-last)
;    (define-key map "g" 'View-goto-line)
;    (define-key map "=" 'what-line)
;    (define-key map "F" 'View-revert-buffer-scroll-page-forward)
;    ;; (define-key map "k" 'View-scroll-line-backward)
;    (define-key map "y" 'View-scroll-line-backward)
;    ;; (define-key map "j" 'View-scroll-line-forward)
;    (define-key map "\n" 'View-scroll-line-forward)
;    (define-key map "\r" 'View-scroll-line-forward)
;    (define-key map "u" 'View-scroll-half-page-backward)
;    (define-key map "d" 'View-scroll-half-page-forward)
;    (define-key map "z" 'View-scroll-page-forward-set-page-size)
;    (define-key map "w" 'View-scroll-page-backward-set-page-size)
;    ;; (define-key map "b" 'View-scroll-page-backward)
;    (define-key map "\C-?" 'View-scroll-page-backward)
;    ;; (define-key map "f" 'View-scroll-page-forward)
;    (define-key map " " 'View-scroll-page-forward)
;    (define-key map "o" 'View-scroll-to-buffer-end)
;    (define-key map ">" 'end-of-buffer)
;    (define-key map "<" 'beginning-of-buffer)
;    (define-key map "-" 'negative-argument)
;    (define-key map "9" 'digit-argument)
;    (define-key map "8" 'digit-argument)
;    (define-key map "7" 'digit-argument)
;    (define-key map "6" 'digit-argument)
;    (define-key map "5" 'digit-argument)
;    (define-key map "4" 'digit-argument)
;    (define-key map "3" 'digit-argument)
;    (define-key map "2" 'digit-argument)
;    (define-key map "1" 'digit-argument)
;    (define-key map "0" 'digit-argument)
;    (define-key map "H" 'describe-mode)
;    (define-key map "?" 'describe-mode)	; Maybe do as less instead? See above.
;    (define-key map "h" 'describe-mode)
;    map))
;


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
;(load "zeitgeist.el")

