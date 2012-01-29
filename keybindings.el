
;(global-set-key (kbd "<f7>") 'move-to-the-word)
;
;(set-key-bindings 'global-set-key	
;                  (list
;                   (list (kbd "<f7>") 'move-to-the-word)
;))

(set-key-bindings 'global-set-key	
 (list 
	 '([f2] calendar)
	 '([(shift f2)] remember)
	 '([f3] artist-mode)
	 '([f5] revert-buffer)
         '([f6] back-to-the-word)
         '([f7] move-to-the-word)
;	 '([f9] transient-mark-mode)
	 '([(shift f9)] hide-region-unhide)
	 '([f9] hide-region-hide) 
	 '([f11] query-replace)
	 '([(shift f11)] query-replace-regexp)
	 '([f12] speedbar-get-focus)
;	 '([f12] replace-string)
	 '([(shift f12)] replace-regexp)
;	 '([M-up] 'move-text-up)
;	 '([M-down] 'move-text-down)
	 '([M-/]   hippie-expand)


         `( ,(kbd "<M-up>") move-text-up)
         `( ,(kbd "<M-down>") move-text-down)

	 `( ,(kbd "<C-f10>") rename-buffer)
	 `( ,(kbd "C-=")   set-mark-command)
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

	 `( ,(kbd "M-F")   forward-symbol)
	 `( ,(kbd "M-B")   backward-symbol)

	 ;; Finding and locating
	 `( ,(kbd "C-x a g") goto-line)
	 `( ,(kbd "C-x a b") back-to-the-word)
	 ;; `( ,(kbd "C-x a s") move-to-the-word)
	 `( ,(kbd "C-x a k") to-the-line-end)
	 `( ,(kbd "C-x a K") erease-to-line-end)
	 `( ,(kbd "C-x a [") backward-paragraph)
	 `( ,(kbd "C-x a ]") forward-paragraph)
	 `( ,(kbd "M-]") move-forward-paren)
	 `( ,(kbd "M-[") move-backward-paren)
	 ;; commands
	 `( ,(kbd "C-c z") eshell)
;	 `( ,(kbd "C-c z") shell)
	 `( ,(kbd "C-c j") jump)

	 `( ,(kbd "C-x 4 4") split-window-4)
	 `( ,(kbd "C-x 4 c") change-split-type)
	;`( ,(kbd "C-x 4 v") split-v)
	 `( ,(kbd "C-x 4 C") change-split-type-3)
	;`( ,(kbd "C-x 4 V") split-v-3)
	 `( ,(kbd "C-x 4 r") roll-v-3)

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
	 `( ,(kbd "C-c v") viper-mode)
	 `( ,(kbd "C-M-s") isearch-forward)
	 `( ,(kbd "C-s") isearch-forward-regexp)
	 `( ,(kbd "C-M-r") isearch-backward)
	 `( ,(kbd "C-r") isearch-backward-regexp)
	 `( ,(kbd "C-x C-b") ibuffer)
	 `( ,(kbd "C-c n") dictionary-search)
	 `( ,(kbd "C-c o") move-to-the-word)
	 `( ,(kbd "C-c O") back-to-the-word)
	 `( ,(kbd "C-c d") duplicate-line)
	 `( ,(kbd "C-c c") ,(lambda() " " (interactive) (if view-mode (View-exit-and-edit) (view-mode))))

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
