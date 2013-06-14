
;(global-set-key (kbd "<f7>") 'move-to-the-word)
;
;(set-key-bindings 'global-set-key	
;                  (list
;                   (list (kbd "<f7>") 'move-to-the-word)
;))

(global-set-key (kbd "C-z") nil)

(global-set-key (kbd "<S-right>") 'tabbar-forward-tab)
(global-set-key (kbd "<S-left>") 'tabbar-backward-tab)

(set-key-bindings 'global-set-key	
 (list 
;	 '([f2] calendar)
	 '([(shift f2)] remember)
	 '([f3] artist-mode)
	 '([f5] revert-buffer)
         '([f6] back-to-the-word)
         '([f7] move-to-the-word)
;	 '([f9] transient-mark-mode)
	 '([f9] hide-region-hide) 
	 '([(shift f9)] hide-region-unhide)
	 '([f11] query-replace)
	 '([(shift f11)] query-replace-regexp)
	 '([(f12)] (lambda (&optional arg)
                     (interactive) 
                     (select-frame-by-name "Ediff")))
;	 '([f12] speedbar-get-focus)
;         '([f12] sr-speedbar-toggle)
;	 '([f12] replace-string)
	 '([(shift f12)] replace-regexp)
;	 '([M-up] 'move-text-up)
;	 '([M-down] 'move-text-down)
	 '([M-/]   hippie-expand)


         `( ,(kbd "<M-up>") move-text-up)
         `( ,(kbd "<M-down>") move-text-down)

	 `( ,(kbd "<C-f10>") rename-buffer)
;	 `( ,(kbd "C-=")   set-mark-command)
	 `( ,(kbd "C-l")   previous-line)
	 `( ,(kbd "C-p")   recenter-top-bottom)
	 `( ,(kbd "C-a")   beginning-of-line)
	 `( ,(kbd "C-S-a") beginning-of-visual-line)
	 ;; copy paste operations 
	 `( ,(kbd "C-=")   set-mark-command)
	 `( ,(kbd "C-c l") copy-line)
	 `( ,(kbd "C-c w") copy-word)
	 `( ,(kbd "C-S-k") ,(lambda()  " " (interactive) (kill-visual-line -1)))
	 `( ,(kbd "C-c s") thing-copy-string-to-mark)
	 `( ,(kbd "C-c a") thing-copy-parenthesis-to-mark)
	 `( ,(kbd "C-c p") copy-paragraph)
	; `( ,(kbd "C-x a q") copy-in-quote-to-mark)   ;; deprecated. use "copy-symbol-to-mark"
	 `( ,(kbd "C-x a d") delete-region)
	 `( ,(kbd "C-S-d") delete-backward-char)

	 `( ,(kbd "M-F")   forward-symbol)
	 `( ,(kbd "M-B")   backward-symbol)

	 ;; Finding and locating
	 `( ,(kbd "C-x a g") goto-line)
	 `( ,(kbd "C-x a b") back-to-the-word)
	 `( ,(kbd "C-x a k") to-the-line-end)
	 `( ,(kbd "C-x a K") erease-to-line-end)
	 `( ,(kbd "M-[") backward-paragraph)
	 `( ,(kbd "M-]") forward-paragraph)
	 `( ,(kbd "M-}") move-forward-paren)
	 `( ,(kbd "M-{") move-backward-paren)
	 ;; commands
;	 `( ,(kbd "C-c z") eshell)
	 `( ,(kbd "C-c z") shell)
	 `( ,(kbd "C-c j") jump)

	 `( ,(kbd "C-x 4 4") split-window-4)
	 `( ,(kbd "C-x 4 c") ,(lambda (&optional arg)
                                (interactive "P")
                                (if (= 2 (length (window-list)))
                                    (change-split-type-2 arg)
                                  (change-split-type-3-v arg))))
	 `( ,(kbd "C-x 4 C") change-split-type-3-h)
	;`( ,(kbd "C-x 4 v") split-v)
	;`( ,(kbd "C-x 4 V") split-v-3)
;	 `( ,(kbd "C-x 4 r") roll-v-3)
	 `( ,(kbd "C-x 4 r") roll-3-buffers)
;	 `( ,(kbd "C-x 4 r") roll-3-buffers-clockwise)
;	 `( ,(kbd "C-x 4 R") roll-3-buffers-anti-clockwise)

	 `( ,(kbd "C-x r p") string-insert-rectangle)

	 `( ,(kbd "C-c m") browse-kill-ring)

	 ;; org-mode key binding
	 `( ,(kbd "C-x a l") org-store-link)
	 `( ,(kbd "C-x a i") org-insert-link)
	 `( ,(kbd "C-c m") pop-to-mark-command)
	 `( ,(kbd "C-/") ska-point-to-register)
	 `( ,(kbd "C-,") ska-jump-to-register)
	;`( ,(kbd "M-s a") emaci-mode-on)
	 `( ,(kbd "s-v") scroll-down)
	 `( ,(kbd "M-d") dove-forward-kill-word)
	 `( ,(kbd "C-c e") exitshell)
	 `( ,(kbd "<insert>") my-overwrite)
	 `( ,(kbd "C-c v") view-mode)
;	 `( ,(kbd "C-c v") viper-mode)
	 `( ,(kbd "C-M-s") isearch-forward)
	 `( ,(kbd "C-s") isearch-forward-regexp)
	 `( ,(kbd "C-M-r") isearch-backward)
	 `( ,(kbd "C-r") isearch-backward-regexp)
	 `( ,(kbd "C-x C-b") ibuffer)
	 `( ,(kbd "C-c n") dictionary-search)
	 `( ,(kbd "C-c o") move-to-the-word)
	 `( ,(kbd "C-c O") back-to-the-word)
	 `( ,(kbd "C-c d") duplicate-line)
	 `( ,(kbd "C-c v") ,(lambda () 
                              (interactive) 
                              (if view-mode 
                                  (progn (View-exit-and-edit) 
                                           (if (memq dove-view-mode-line mode-line-format) 
                                               (setq mode-line-format 
                                                     (delq dove-view-mode-line mode-line-format))))
                                         (view-mode))))

	 `( ,(kbd "M-DEL")
	   ,(lambda(&optional arg) 
	     "Act as the obsolete dove-backward-kill-word " 
	     (interactive "P")
	     (if arg 
		 (let ((arg (- 0 arg))) (dove-forward-kill-word arg))
	       (dove-forward-kill-word -1))))
         ;; tabbar-mode
         `( ,(kbd "C-c <C-right>") tabbar-forward)
         `( ,(kbd "C-c <C-left>" ) tabbar-backward)
         `( ,(kbd "<f6>") back-to-the-word)
         `( ,(kbd "<f7>") move-to-the-word)
))


;(global-set-key [down-mouse-1] 'mouse-set-point)


; (add-hook 'view-mode-hook
;           (lambda ()
;             (define-key view-mode-map "o" (lambda nil (interactive) (View-scroll-line-backward (/ (window-height) 2))) )
;             (define-key view-mode-map "e" (lambda nil (interactive) (View-scroll-line-forward  (/ (window-height) 2))) )
;             (define-key view-mode-map "j" 'View-scroll-page-forward)
;             (define-key view-mode-map "k" 'View-scroll-page-backward)))

(defmacro dove-easy-scroll (mode-map)
  `(lambda ()
     (define-key ,mode-map "o" (lambda nil (interactive) (scroll-down (/ (window-height) 2))))
     (define-key ,mode-map "e" (lambda nil (interactive) (scroll-up (/ (window-height) 2))))
     (define-key ,mode-map "k" (lambda nil (interactive) (previous-line)))
     (define-key ,mode-map "j" (lambda nil (interactive) (next-line )))
     (define-key ,mode-map "+" (lambda nil (interactive) (show-entry)))
     (define-key ,mode-map "-" (lambda nil (interactive) (hide-entry)))
     (define-key ,mode-map "N" (lambda nil (interactive) (View-search-last-regexp-forward)))
     (define-key ,mode-map "P" (lambda nil (interactive) (View-search-last-regexp-backward)))
     (define-key ,mode-map "p" (lambda nil (interactive) (previous-line)))
     (define-key ,mode-map "n" (lambda nil (interactive) (next-line )))
     (define-key ,mode-map ";" (lambda nil (interactive) (show-entry)))
     (define-key ,mode-map "q" (lambda nil (interactive) (hide-entry)))
))

; (macroexpand '(dove-easy-scroll Info-mode-map))

(add-hook 'view-mode-hook
          (dove-easy-scroll view-mode-map))

(add-hook 'view-mode-hook
          (lambda ()
            (defvar view-mode-textual (purecopy " View")
              "The string displayed in the mode line when in overwrite mode.")
            (add-to-list 'mode-line-format 
                         (propertize view-mode-textual 'face '(:foreground "white" :background "red")))
            (setq dove-view-mode-line (car mode-line-format)))

)

(add-hook 'sr-mode-hook
          (lambda ()
            (define-key sr-mode-map "j" 'dired-goto-file)))

(add-hook 'Info-mode-hook
          (dove-easy-scroll Info-mode-map))
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "/" 'dired-goto-file)))
; (setq Info-mode-hook nil)
; (setq view-mode-hook nil)

(eval-after-load 'w3m
  '(progn
     (add-hook 'w3m-mode-hook (lambda ()
               (define-key w3m-mode-map "e" (lambda nil (interactive) (w3m-scroll-up-1 (/ (window-height) 2))))  
               (define-key w3m-mode-map "o" (lambda nil (interactive) (w3m-scroll-up-1 (- 0 (/ (window-height) 2)))))
               (define-key w3m-mode-map "h" 'w3m-view-previous-page)
               (define-key w3m-mode-map "l" 'w3m-view-next-page)
               (define-key w3m-mode-map (kbd "C-w") 'w3m-close-window)))))

(add-hook 'latex-mode-hook
	  (lambda()
            (local-set-key "{" 'skeleton-pair-insert-maybe)))

(add-hook 'hs-minor-mode-hook
  '(lambda ()
     (setq hs-minor-mode t)
     (define-key hs-minor-mode-map '([f8] hs-hide-block))
     (define-key hs-minor-mode-map '([shift f8] hs-show-block))))

(add-hook 'slime-repl-mode-hook 
          (lambda ()
            (set-key-bindings 'local-set-key
                              `( ,(kbd "C-c C-q") 'slime-close-all-parens-in-sexp))))

(add-hook 'slime-mode-hook 
          (lambda ()
            (set-key-bindings 'local-set-key 
                              `( ,(kbd "C-c C-q") 'slime-close-all-parens-in-sexp))))
(add-hook 'Man-mode-hook
          (lambda ()
            (view-mode)))
;(global-set-key (kbd "C-x C-f") `helm-find-files)
(add-hook 'vc-dir-mode-hook
          (lambda ()
            (define-key vc-dir-mode-map "d" 'vc-ediff)))
                              
(global-set-key (kbd "C-c 0") 'delete-window-next)
;(define-key ctl-x-5-map (kbd "C-x 5 0") 'delete-window-next)
