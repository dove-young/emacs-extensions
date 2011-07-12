
;(mapcar (lambda(lst)
;	  ""
;	  (let ((x (car lst))
;		(y (car (last lst))))
;	    (global-set-key x y)))
;	(list 
;	 '([f2] calendar)
;	 '([(shift f2)] remember)
;	 '([f5] revert-buffer)
;	 '([f10] rename-buffer)
;	 '([f11] query-replace)
;	 '([(shift f11)] query-replace-regexp)
;	 '([f12] replace-string)
;	 '([(shift f12)] replace-regexp)
;	 '([f9] transient-mark-mode)
;	 '([(shift f9)] hide-region-unhide)
;	 '([f9] hide-region-hide)   
;	 '([f3] artist-mode)
;
;	 (list (kbd "C-=") 'set-mark-command)
;))

(set-key-bindings 'global-set-key	
 (list 
	 '([f2] calendar)
	 '([(shift f2)] remember)
	 '([f5] revert-buffer)
	 '([f11] query-replace)
	 '([(shift f11)] query-replace-regexp)
	 '([f12] speedbar-get-focus)
;	 '([f12] replace-string)
	 '([(shift f12)] replace-regexp)
;	 '([f9] transient-mark-mode)
	 '([(shift f9)] hide-region-unhide)
	 '([f9] hide-region-hide)   
	 '([f3] artist-mode)
;	 '([M-up] 'move-text-up)
;	 '([M-down] 'move-text-down)
	 '([M-/]   'hippie-expand)

         (list (kbd "<M-up>") 'move-text-up)
         (list (kbd "<M-down>") 'move-text-down)

	 (list (kbd "<C-f10>") 'rename-buffer)
	 (list (kbd "C-=")   'set-mark-command)
	 (list (kbd "C-l")   'previous-line)
	 (list (kbd "C-p")   'recenter-top-bottom)
	 (list (kbd "C-a")   'beginning-of-line)
	 (list (kbd "C-S-a") 'beginning-of-visual-line)
	 ;; copy paste operations 
	 (list (kbd "C-=")   'set-mark-command)
	 (list (kbd "C-c l") 'copy-line)
	 (list (kbd "C-c w") 'copy-word)
	 (list (kbd "C-S-k") (lambda()  " " (interactive) (kill-visual-line -1)))

	 (list (kbd "C-c s") 'thing-copy-string-to-mark)
	 (list (kbd "C-c a") 'thing-copy-parenthesis-to-mark)
	 (list (kbd "C-c p") 'copy-paragraph)
	; (list (kbd "C-x a q") 'copy-in-quote-to-mark)   ;; deprecated. use "copy-symbol-to-mark"
	 (list (kbd "C-x a d") 'delete-region)

	 (list (kbd "M-F")   'forward-symbol)
	 (list (kbd "M-B")   'backward-symbol)

	 ;; Finding and locating
	 (list (kbd "C-x a g") 'goto-line)
	 (list (kbd "C-x a b") 'back-to-the-word)
	 ;; (list (kbd "C-x a s") 'move-to-the-word)
	 (list (kbd "C-x a k") 'to-the-line-end)
	 (list (kbd "C-x a K") 'erease-to-line-end)
	 (list (kbd "C-x a [") 'backward-paragraph)
	 (list (kbd "C-x a ]") 'forward-paragraph)
	 (list (kbd "M-]") 'move-forward-paren)
	 (list (kbd "M-[") 'move-backward-paren)
	 ;; commands
	 (list (kbd "C-c z") 'shell)
	 (list (kbd "C-c j") 'jump)

	 (list (kbd "C-x 4 4") 'split-window-4)
	 (list (kbd "C-x 4 c") 'change-split-type)
	;(list (kbd "C-x 4 v") 'split-v)
	 (list (kbd "C-x 4 C") 'change-split-type-3)
	;(list (kbd "C-x 4 V") 'split-v-3)
	 (list (kbd "C-x 4 r") 'roll-v-3)

	 (list (kbd "C-x r p") 'string-insert-rectangle)

	 (list (kbd "C-c m") 'browse-kill-ring)

	 ;; org-mode key binding
	 (list (kbd "C-x a l") 'org-store-link)
	 (list (kbd "C-x a i") 'org-insert-link)
	 (list (kbd "C-c m") 'pop-to-mark-command)
	 (list (kbd "C-/") 'ska-point-to-register)
	 (list (kbd "C-,") 'ska-jump-to-register)
	;(list (kbd "M-s a") 'emaci-mode-on)
	 (list (kbd "s-v") 'scroll-down)
	 (list (kbd "M-d") 'dove-forward-kill-word)
	 (list (kbd "C-c e") 'exitshell)
	 (list (kbd "<insert>") 'my-overwrite)
	 (list (kbd "C-c v") 'viper-mode)
	 (list (kbd "C-M-s") 'isearch-forward)
	 (list (kbd "C-s") 'isearch-forward-regexp)
	 (list (kbd "C-M-r") 'isearch-backward)
	 (list (kbd "C-r") 'isearch-backward-regexp)
	 (list (kbd "C-x C-b") 'ibuffer)
	 (list (kbd "C-c n") 'dictionary-search)
	 (list (kbd "C-c o") 'move-to-the-word)
	 (list (kbd "C-c O") 'back-to-the-word)
	 (list (kbd "C-c d") 'duplicate-line)
	 (list (kbd "C-c c") '(lambda() " " (interactive) (if view-mode (View-exit-and-edit) (view-mode))))

	 (list (kbd "M-DEL")
	   (lambda(&optional arg) 
	     "Act as the obsolete dove-backward-kill-word " 
	     (interactive "P")
	     (if arg 
		 (let ((arg (- 0 arg))) (dove-forward-kill-word arg))
	       (dove-forward-kill-word -1))))
         ;; tabbar-mode
         (list (kbd "C-c <C-right>") 'tabbar-forward)
         (list (kbd "C-c <C-left>" ) 'tabbar-backward)
))