;;; dove-ext.el --- Emacs minor extensions written by David young

;; Copyright (C) 2009  David Young <dove.young@gmail.com>

;; Author: David Young
;; Maintainer: David Young <dove.young@gmail.com>
;; Keywords: shell,shell-mode, copy, help, tools, convenience
;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/dove-ext.el
;; Site: http://www.emacswiki.org/cgi-bin/emacs/DavidYoung

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;; miscellaneous

;; 2010-08-04 improved rename-buffer-in-ssh-login function
;; 2010-08-08 rewrote function rename-buffer-in-ssh-login
;; 2010-08-08 added function rename-buffer-in-ssh-exit
;; 2010-08-21 added my-overwrite, updated jump function
;; 2010-09-18 added very fancy function split-v-3 and split-h-3
;; 2010-09-27 added roll-v-3
;; 2010-10-01 Rewrote some functions in more Lisp like style
;; 2010-10-09 Rewrote those functions related to copy without selection

(defun get-point (symbol &optional arg)
 "get the point"
     (progn (funcall symbol arg) (point)))

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
      (let ((beg (get-point begin-of-thing 1))
	    (end (get-point end-of-thing arg)))
	(copy-region-as-kill beg end))
)

(defun paste-to-mark(condition &optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
	 (lambda()
	   (if (funcall condition)
	     (progn (comint-next-prompt 25535) (yank))
	   (progn (goto-char (mark)) (yank) )))))
	(if arg
	    (if (= arg 1)
		nil
	      (funcall pasteMe))
	  (funcall pasteMe) )))
	      
(defun test-get-point (&optional arg)
  "test-get-point"
  (interactive "P")
  (message "%s" (get-point 'forward-word 3))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                 ;;
;;             shell mode related                  ;;
;;                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun come-here (&optional arg)
  "Bring content from specific buffer to current buffer"
  (interactive (list (let (( arg (read-buffer "Input buffer Name: " "*Shell Command Output*") ))
            (insert-buffer-substring (get-buffer arg))  ))
  )
)


(defun ccc (&optional some)
  "try interactive"
  (interactive (list (let ((some (read-string "Input a string: " nil) ))
             (message "%S" "erwerw") )
        ) )
)


(defun jump (&optional arg)
  "Put current line to another window."
  (interactive "P")
  (let ((command (comint-get-old-input-default))
	 (num (or arg 1)))
       (progn (other-window num)
	      ;; if in shell-mode, goto shell input prompt, else just insert at point
	      (if (string= "shell-mode" major-mode)
		  (progn
		    (goto-char (point-max))
		    ;; First delete any old unsent input at the end
		    (delete-region
		     (or (marker-position comint-accum-marker)
			 (process-mark (get-buffer-process (current-buffer))))
		     (point))
		    )
		)
	      (insert command)
	      )
       )
)


;(defun beforeLast (&optional arg)
;  (interactive "P")
;  (let ((num (or arg 1)))
;    (comint-previous-prompt num)
;    )
;  (let ((input (funcall comint-get-old-input))
;	      (goto-char (process-mark process))
;
;	      (insert input))))
;
;

;(defun some (&optional arg)
;  "Delete Shell command output, to which C-c C-o cannot do for you."
;  (interactive "P")
;  (let ((end 
;	 (get-point  '(lambda (&optional arg) "" (interactive "P")
;		(comint-previous-prompt (or arg 1))
;;		(previous-line)   -- this command is for interactive only
;		(forward-line -1)
;;		(move-beginning-of-line 1)
;		(move-end-of-line 1)
;		)  arg))
;	(start
;	 (get-point '(lambda (&optional arg) "" (interactive "P")
;		 (comint-previous-prompt 1)
;;		(next-line)
;		(move-beginning-of-line 2)
;		)  arg))
;	)
;    (delete-region start end)
;    )
;
;)

 (defun mywrite-region (&optional string)
   "Append current region to specified file. Leverage write-region to implement this function"
   (interactive "BInput file name: ")
   (write-region (region-beginning) (region-end) string "append")
 )


(defun matrixSum (start end)
  "Calculate matrix statistics by row & column. Then insert result into current buffer."
  (interactive "r")
  (progn (shell-command-on-region start end "matrixSum")
	 (let ((buf "*Shell Command Output*"))
	   (progn (come-here buf) (kill-buffer buf) (delete-other-windows))
	   )
	   )
)


(defun exitshell(&optional arg)
  " Exit from login shell, with prefix to exit many levels "
  (interactive "P")
  (let (( nlist (make-list (or arg 1) 1) ))
    (while nlist
      (comint-next-prompt 1)
      (insert "exit ")
      (comint-send-input)
      (sit-for 1)
      (pop nlist)
      )
    )
)


; The function will ignore command like this
; ssh msg@tivx24.cn.ibm.com ls bin
; It could response only to command like this
; ssh msg@tivx24.cn.ibm.com 

(add-hook 'shell-mode-hook 
	  (lambda()
	    (setq shell-buffer-name-list (list "*shell*") )
	    (message "%s" shell-buffer-name-list)
	    )
	  t
)

(eval-after-load 'shell
  '(progn

      ; rewrote this function to co-work with rename-buffer-in-ssh-exit

      (defun rename-buffer-in-ssh-login (cmd)
        "Rename buffer to the destination hostname in ssh login"
        (if (string-match "ssh .* [-_a-z0-9A-Z]+@[-_a-z0-9A-Z.]+[ ]*[^-_a-z0-9-A-Z]*$" cmd)
            (let (( host (nth 1 (split-string cmd "[@\n]" t) ))
      	    )
;            (message "%s" (split-string cmd "[ @\n]" t) )
            (rename-buffer (concat "*" host))
            (add-to-list 'shell-buffer-name-list (concat "*" host))
            (message "%s" shell-buffer-name-list)
            )
          )
      ;  (if (string-match "^bash$") 
      ;      (add-to-list 'shell-buffer-name-list nil)
      ;    )
      )
      (add-hook 'comint-input-filter-functions 'rename-buffer-in-ssh-login)
      
      ;; This function works only in a single shell session. 
      ;; Not sure how to make it work and safe in multi-session.
      ;; how to handle commands like 'bash' and then 'exit' is also a problem

;;      (defun rename-buffer-in-ssh-exit (cmd)
;;        "Rename buffer to its previous name when user exit from a ssh login"
;;      ;  (message "%s" cmd)
;;        (message "%s" shell-buffer-name-list)
;;        (if (string-match "^exit$" cmd)
;;            (if (> (length shell-buffer-name-list) 1)
;;      	  (progn (pop shell-buffer-name-list)
;;      		 (rename-buffer  (car shell-buffer-name-list)))
;;          )
;;        )
;;        (message "%s" shell-buffer-name-list)
;;      )
      	     
;;      (add-hook 'comint-input-filter-functions 'rename-buffer-in-ssh-exit t)
     
      
      (defun kill-shell-buffer(process event)
        "The one actually kill shell buffer when exit. "
        (kill-buffer (process-buffer process))
      )
      
      (defun kill-shell-buffer-after-exit()
        "kill shell buffer when exit."
        (set-process-sentinel (get-buffer-process (current-buffer))
      		      #'kill-shell-buffer)
      )
      
      (add-hook 'shell-mode-hook 'kill-shell-buffer-after-exit t)

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                 ;;
;;             copy & paste related                ;;
;;                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun insert-buffer-name (&optional arg)
 "Insert current buffer name at point"
  (interactive (list (let (( arg  (read-buffer "Input buffer Name: " (buffer-name (current-buffer))) ))
            (insert (buffer-name (get-buffer arg)))  ))
  )
)


(defun copy-line (&optional arg)
 "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  (paste-to-mark (lambda () (string= "shell-mode" major-mode)) arg)
)

(defun duplicate-line(&optional arg)
   "duplicate current line"
   (interactive "P")
   (let ((line (thing-at-point 'line)))
     (forward-line)
     (insert line)
     (forward-line -1)
     (if arg
	 (if (> arg 1)
	     (duplicate-line (- arg 1) -1)))))

(defun copy-word (&optional arg)
 "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  (paste-to-mark (lambda () (string= "shell-mode" major-mode)) arg)
)

(defun copy-paragraph (&optional arg)
 "Copy paragraphes at point"
  (interactive "P")
  (copy-thing 'backward-paragraph 'forward-paragraph arg)
  (paste-to-mark (lambda () (string= "shell-mode" major-mode)) arg)
)


;(defun dove-backward-kill-word (&optional arg)
;  "Backward kill word, but do not insert it into kill-wring"
;  (interactive "P")
;  (let (( end (point) )
;	( beg (progn (backward-word arg ) (point)))
;	      )
;    (delete-region beg end)
;    )
;)

(defun dove-forward-kill-word (&optional arg)
  "Backward kill word, but do not insert it into kill-wring"
  (interactive "P")
  (let (( beg (point) )
	( end (get-point 'forward-word arg)))
    (delete-region beg end)
    )
)

;; (defun copy-string-to-mark (&optional arg)
;;  "Copy a sequence of string into kill-ring and then paste to the mark point"
;;   (interactive "P")
;;   (let (
;;	 (onPoint (point))
;;	 )
;;     (let (
;;
;;	 ( beg 	(progn (re-search-backward "[\t ]" (line-beginning-position) 3 1)
;;			  (if (looking-at "[\t ]") (+ (point) 1) (point) ) )
;;		)
;;          ( end  (progn  (goto-char onPoint) (re-search-forward "[\t ]" (line-end-position) 3 1)
;;			  (if (looking-back "[\t ]") (- (point) 1) (point) ) )
;;		 )
;;	  )
;;       (copy-region-as-kill beg end)
;;       (message "%s" major-mode)
;;       (if (string= "shell-mode" major-mode)
;;	   (progn (comint-next-prompt 25535) (yank))
;;	 ;; unless arg == 0, paste content to mark, else hold in kill ring
;;	   (unless (> (or arg 0) 0) (progn (goto-char (mark)) (yank) )))
;;
;;       )
;;     )
;; )


(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t]" (line-beginning-position) 3 1)
	     (if (looking-at "[\t ]")  (goto-char (+ (point) 1)) )
)
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t]" (line-end-position) 3 arg)
	     (if (looking-back "[\t ]") (goto-char (- (point) 1)) )
)
;(defun amark (&optional arg)
;  ""
;  (interactive "P")
;  (pop-mark)
;  (message "%s  %s" (mark) (point))
;)


(defun go-there(arg) 
  ""
  (goto-char (funcall arg)))


(defun thing-copy-string-to-mark(&optional arg)
  " Try to copy a string at point, or a region selected  and paste it to the mark. 
When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (cond 
   ((and mark-active transient-mark-mode)
    (pop-mark)
    )
   (t
;      (message "%s" "223 456")
    (copy-thing 'beginning-of-string 'end-of-string arg)))
    (paste-to-mark (lambda () (string= "shell-mode" major-mode)) arg)
)

(defun beginning-of-parenthesis(&optional arg)
  "  "
  (re-search-backward "[[<(?\"]" (line-beginning-position) 3 1)
	     (if (looking-at "[[<(?\"]")  (goto-char (+ (point) 1)) )
)
(defun end-of-parenthesis(&optional arg)
  " "
  (re-search-forward "[]>)?\"]" (line-end-position) 3 arg)
	     (if (looking-back "[]>)?\"]") (goto-char (- (point) 1)) )
)

(defun thing-copy-parenthesis-to-mark(&optional arg)
  " Try to copy a parenthesis and paste it to the mark
When used in shell-mode, it will paste parenthesis on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-parenthesis 'end-of-parenthesis arg)
  (paste-to-mark (lambda () (string= "shell-mode" major-mode)) arg)
)

(defun backward-symbol (&optional arg)
  (interactive "P")
  "Go backward a symbol, just like forward-symbol, by provide a -1 arg to it"
   (if arg  (forward-symbol arg) (forward-symbol -1))
   (message "%s" arg)
)

(defun move-forward-paren (&optional arg)

  (interactive "sInput a Parenthesis:")
  (message "%s" arg)
  (re-search-forward arg (point-max) 3 1)
)

(defun move-backward-paren (&optional arg)

  (interactive "sInput a Parenthesis:")
  (message "%s" arg)
  (re-search-backward arg (point-max) 3 1)
)

(defun move-to-the-word (&optional arg)
 "Moving to next occurrance of current word"
 (interactive "P")
 (let (( cur-word (current-word nil nil) ))
   (message "%s" cur-word)
   (search-forward cur-word))
)

(defun back-to-the-word (&optional arg)
 "Moving to next occurrance of current word"
 (interactive "P")
 (let (( cur-word (current-word nil nil) ))
   (message "%s" cur-word)
   (search-backward cur-word))
)


(defun convert-Table(start end)
"Convert Emacs table into HTML table"
  (interactive "r")
    (shell-command-on-region start end "sed -e 's%^.%<tr><td>&%' -e 's%    *%</td><td>%g' -e 's%<td>$%</tr>%'")
	 (set-buffer "*Shell Command Output*")
;	 (beginning-of-buffer)
	 (goto-char (point-min))
	 (insert "<table border=\"1\" cellspacing=\"0\" cellpadding=\"0\">\n")
;	 (end-of-buffer)
	 (goto-char (point-max))
	 (insert "</table>\n")
)


(defun insert-line-number(&optional arg)
  "Insert a numeric sequence at beginning of each line"
  (interactive "P")
  (let ((insert-number 
	 (lambda (start beg end)
	   "insert a numeric sequence at beginning of each line"
	   (goto-char beg)
	   (beginning-of-line)
	   (insert (number-to-string start))
	   (setq start (+ start 1))
	   (while (< (point) end)
	     (beginning-of-line 2)
	     (insert (number-to-string start))
	     (setq start (+ start 1))))))
    (cond 
     ((or mark-active transient-mark-mode)
      (if (> (point) (mark))
	  (exchange-point-and-mark))
      (if arg
	  (funcall insert-number arg (point) (mark))
	  (funcall insert-number 0 (point) (mark)))
      )
     (t
      (if arg
	  (funcall insert-number arg (point-min) (point-max))
	(funcall insert-number 0 (point-min) (point-max)))
      ))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                 ;;
;;             window layout related               ;;
;;                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;  +-----------------------+----------------------+
;  |                       |                      |
;  |                       |                      |
;  |                       |                      |
;  +-----------------------+----------------------+
;  |                       |                      |
;  |                       |                      |
;  |                       |                      |
;  +-----------------------+----------------------+

(defun split-window-4()
 "Splite window into 4 sub-window"
 (interactive)
 (if (= 1 (length (window-list)))
     (progn (split-window-vertically)
	    (split-window-horizontally)
	    (other-window 2)
	    (split-window-horizontally)
	    )
   )
)

;;  +----------------------+                 +----------- +-----------+ 
;;  |                      |           \     |            |           | 
;;  |                      |   +-------+\    |            |           | 
;;  +----------------------+   +-------+/    |            |           |
;;  |                      |           /     |            |           | 
;;  |                      |                 |            |           | 
;;  +----------------------+                 +----------- +-----------+ 
;
;(defun split-v ()
;  (interactive)
;  (if (= 2 (length (window-list)))
;    (let (( thisBuf (window-buffer))
;	  ( nextBuf (progn (other-window 1) (buffer-name))))
;	  (progn   (delete-other-windows)
;		   (split-window-horizontally)
;		   (set-window-buffer nil thisBuf)
;		   (set-window-buffer (next-window) nextBuf)
;		   ))
;    )
;)


;;  +----------- +-----------+                  +----------------------+ 
;;  |            |           |            \     |                      | 
;;  |            |           |    +-------+\    |                      | 
;;  |            |           |    +-------+/    +----------------------+ 
;;  |            |           |            /     |                      | 
;;  |            |           |                  |                      | 
;;  +----------- +-----------+                  +----------------------+ 
;
;(defun split-h ()
;  (interactive)
;  (if (= 2 (length (window-list)))
;    (let (( thisBuf (window-buffer))
;	  ( nextBuf (progn (other-window 1) (buffer-name))))
;	  (progn   (delete-other-windows)
;		   (split-window-vertically)
;		   (set-window-buffer nil thisBuf)
;		   (set-window-buffer (next-window) nextBuf)
;		   ))
;    )
;)


;  +----------------------+                +---------- +----------+
;  |                      |          \     |           |          |
;  |                      |  +-------+\    |           |          |
;  +----------------------+  +-------+/    |           |          |
;  |                      |          /     |           |          |
;  |                      |                |           |          |
;  +----------------------+                +---------- +----------+
;
;  +--------- +-----------+                +----------------------+
;  |          |           |          \     |                      |
;  |          |           |  +-------+\    |                      |
;  |          |           |  +-------+/    +----------------------+
;  |          |           |          /     |                      |
;  |          |           |                |                      |
;  +--------- +-----------+                +----------------------+



(defun change-split-type ()
  "Changes splitting from vertical to horizontal and vice-versa"
  (interactive)
  (if (= 2 (length (window-list)))
      (let ((thisBuf (window-buffer))
            (nextBuf (progn (other-window 1) (buffer-name)))
            (split-type (if (= (window-width)
                               (frame-width))
                            'split-window-horizontally
                            'split-window-vertically)))
        (progn
          (delete-other-windows)
	  (funcall split-type)
          (set-window-buffer nil thisBuf)
          (set-window-buffer (next-window) nextBuf)))))



;  +-----------------------+                  +----------- +-----------+ 
;  |                       |            \     |            |           | 
;  |                       |    +-------+\    |            |           | 
;  +-----------------------+    +-------+/    |            |-----------|
;  |           |           |            /     |            |           | 
;  |           |           |                  |            |           | 
;  +-----------------------+                  +----------- +-----------+ 

;  +----------- +-----------+                  +----------------------+ 
;  |            |           |            \     |                      | 
;  |            |           |    +-------+\    |                      | 
;  |            |-----------|    +-------+/    +----------------------+ 
;  |            |           |            /     |           |          | 
;  |            |           |                  |           |          | 
;  +----------- +-----------+                  +----------------------+ 

(defun change-split-type-3 ()
  "Change 3 window style from horizontal to vertical and vice-versa"
  (interactive "p")
  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
	    (let ((1stBuf (window-buffer (car winList)))
		  (2ndBuf (window-buffer (car (cdr winList))))
		  (3rdBuf (window-buffer (car (cdr (cdr winList)))))
		  (split-3 
		   (lambda(1stBuf 2ndBuf 3rdBuf split-1 split-2)
		     "change 3 window from horizontal to vertical and vice-versa"
		     (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)
		     (delete-other-windows)
		     (funcall split-1)
		     (set-window-buffer nil 2ndBuf)
		     (funcall split-2)
		     (set-window-buffer (next-window) 3rdBuf)
		     (other-window 2)
		     (set-window-buffer nil 1stBuf)))
		  (split-type-1 nil)
		  (split-type-2 nil)
		  )
	      (if (= (window-width) (frame-width))
		  (setq split-type-1 'split-window-horizontally split-type-2 'split-window-vertically)
		(setq split-type-1 'split-window-vertically  split-type-2 'split-window-horizontally))
	      (funcall split-3 1stBuf 2ndBuf 3rdBuf split-type-1 split-type-2)

))))


;;  +----------- +-----------+                  +----------------------+ 
;;  |            |           |            \     |                      | 
;;  |            |           |    +-------+\    |                      | 
;;  |            |-----------|    +-------+/    +----------------------+ 
;;  |            |           |            /     |          |           | 
;;  |            |           |                  |          |           | 
;;  +----------- +-----------+                  +----------------------+ 
;
;
;(defun split-h-3 ()
;  "Change 3 window style from vertical to horizontal"
;  (interactive)
;  (select-window (get-largest-window))
;  (if (= 3 (length (window-list)))
;      (let ((winList (window-list)))
;	    (let ((1stBuf (window-buffer (car winList)))
;		  (2ndBuf (window-buffer (car (cdr winList))))
;		  (3rdBuf (window-buffer (car (cdr (cdr winList))))))
;
;		(message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)
;		(delete-other-windows)
;		(split-window-vertically)
;		(set-window-buffer nil 1stBuf)
;		(other-window 1)
;		(set-window-buffer nil 2ndBuf)
;		(split-window-horizontally)
;		(set-window-buffer (next-window) 3rdBuf)
;		(select-window (get-largest-window))
;	      )
;	    )
;    )
;)

;  +----------- +-----------+                    +----------- +-----------+ 
;  |            |     C     |            \       |            |     A     | 
;  |            |           |    +-------+\      |            |           | 
;  |     A      |-----------|    +-------+/      |     B      |-----------| 
;  |            |     B     |            /       |            |     C     | 
;  |            |           |                    |            |           | 
;  +----------- +-----------+                    +----------- +-----------+ 
;
;  +------------------------+                     +------------------------+ 
;  |           A            |           \         |           B            | 
;  |                        |   +-------+\        |                        | 
;  +------------------------+   +-------+/        +------------------------+ 
;  |     B     |     C      |           /         |     C     |     A      | 
;  |           |            |                     |           |            | 
;  +------------------------+                     +------------------------+ 


  (defun roll-v-3 (&optional arg)
    "Rolling 3 window buffers clockwise"
    (interactive "P")
    (select-window (get-largest-window))
    
    (let ((winList (window-list))
          (set-buf (lambda (lst) (set-window-buffer (car lst) (car (last lst))))))
      (if (= 3 (length winList))
          (let ((1stWin (car winList))
                (2ndWin (car (cdr winList)))
                (3rdWin (car (last winList))))

;            (let ((1stBuf (window-buffer 1stWin))
;                  (2ndBuf (window-buffer 2ndWin))
;                  (3rdBuf (window-buffer 3rdWin)))
	      (let ((anti-clockwise (list 
				(list 1stWin (window-buffer 3rdWin)) 
				(list 2ndWin (window-buffer 1stWin)) 
				(list 3rdWin (window-buffer 2ndWin))))
		    (clock-wise (list 
				      (list 1stWin (window-buffer 2ndWin)) 
				      (list 2ndWin (window-buffer 3rdWin)) 
				      (list 3rdWin (window-buffer 1stWin)))))
	      (if arg (mapc set-buf clockwise)
		(mapc set-buf anti-clock-wise)))))))

;              (if arg (mapc set-buf (list (list 1stWin 2ndBuf) (list 2ndWin 3rdBuf) (list 3rdWin 1stBuf)))
;                (mapc set-buf (list (list 1stWin 3rdBuf) (list 2ndWin 1stBuf) (list 3rdWin 2ndBuf)) )))))))
;
;(defun dove-hide-shell-output()
;  "Hide Shell Output"
;  (interactive)
;;  (let ((beg (progn (move-end-of-line 0) (point))))
;;        (end (progn (comint-previous-prompt 0) (move-beginning-of-line 2) (point)
;;
;;   (set-mark-command (progn (move-end-of-line 0) (point)))
;  (let ((start (point)))
;    (progn
;      (comint-previous-prompt 1)
;      (move-beginning-of-line 2)
;      (set-mark (point))
;      (comint-next-prompt 1)
;      (move-end-of-line -1)
;      (hide-region-hide)
;      (set-mark start))
;    )
;)

;; edit related

;(defun try-expand-dabbrev-path (old)
;  (setq hippie-expand-dabbrev-as-symbol nil)
;  (try-expand-dabbrev old)
;  (setq hippie-expand-dabbrev-as-symbol t)
;)

;(message "%s" hippie-expand-try-functions-list)

(setq hippie-expand-try-functions-list
      (append (list (car  hippie-expand-try-functions-list)
	       'try-expand-dabbrev-path)
	      (cdr  hippie-expand-try-functions-list)
	      )
)

(defun my-overwrite (&optional arg)
  "Encapsulate overwrite-mode function, to enable red alert in mode-line "
  (interactive "P")
  (if (not overwrite-mode)
      (progn (add-to-list 'mode-line-format (propertize overwrite-mode-textual 'face '(:foreground "white" :background "red") ))
	     (setq my-overwrite-mode-line (car mode-line-format))
	     (overwrite-mode 1)
	     )
    (progn (overwrite-mode 0)
	   (if (memq my-overwrite-mode-line mode-line-format) (setq mode-line-format (delq my-overwrite-mode-line mode-line-format)))
	   )
    )
)


; auto-type

(defun i-babel-quote (beg end str1 str2)
  (goto-char end)
  (forward-line 1)
  (insert str2)
  (newline)
  (goto-char beg)
  (forward-line -1)
  (newline)
  (insert str1)
)

(defun iexp (St Ed)
  "Enclose example for org-mode"
  (interactive "r")
  (let ((beg St) (end Ed))
    (message "%s %s" beg end)
    (i-babel-quote beg end "#+BEGIN_EXAMPLE" "#+END_EXAMPLE")))

(defun isrc (St Ed)
  "Enclose code for org-mode"
  (interactive "r")
  (let ((beg St) (end Ed))
    (message "%s %s" beg end)
    (i-babel-quote beg end "#+begin_src " "#+end_src")))


(defun ihtml (St Ed)
  "Enclose code for Emacser.cn"
  (interactive "r")
  (let ((beg St) (end Ed))
    (message "%s %s" beg end)
    (i-babel-quote beg end 
		   (concat "#+BEGIN_HTML\n " "<pre lang=\"lisp\" line=\"1\">\n")

		   (concat "</pre>\n" "#+END_HTML\n")
		   )))


(defun i= (St Ed)
  ""
  (interactive "r")
  (let ((beg St) (end Ed))
    (goto-char end)
    (insert "=")
    (goto-char beg)
    (insert "=")
    (goto-char (+ end 2)))
)


(defun i* (St Ed)
  ""
  (interactive "r")
  (let ((beg St) (end Ed))
    (goto-char end)
    (insert "*")
    (goto-char beg)
    (insert "*")
    (goto-char (+ end 2)))
)


(defun action-to-list (action lst)
  "Perform action to each element in the list"
  (mapcar (lambda(ext) (funcall action ext)) lst))


;(defun require-extensions (action lst)
;  ""
;  (mapcar (lambda(ext) "" (funcall action ext)) lst))


(defun set-key-bindings (action bindingList)
  ""
  (mapcar (lambda(lst)
	  ""
	  (let ((x (car lst))
		(y (car (last lst))))
	    (funcall action x y))) bindingList ))

(defun set-outline-minor-mode-regexp ()
  ""
  (outline-minor-mode 1)
;  (setq outline-regexp 
  (let ((regexp-list (append outline-minor-mode-list nil))
	(find-regexp
	 (lambda (lst)
	   ""
	   (let ((innerList (car lst)))
	     (if innerList
		 (if (string= (car innerList) major-mode)
		     (car (cdr innerList))
		   (progn (pop lst)
			  (funcall find-regexp lst))))
	     ))))
;    (message "%s  %s" major-mode regexp-list)
    (make-local-variable 'outline-regexp)
    (setq outline-regexp (funcall find-regexp regexp-list))
;    (message "%s" outline-regexp)
    )
	
  (set-key-bindings 'local-set-key
		    (list
		     (list (kbd "C-c C-t") 'hide-body)
		     (list (kbd "C-c C-a") 'show-all)
		     (list (kbd "C-c C-e") 'show-entry)
		     ))
)

(defun hs-hide-all-comments ()
  "Find all comments in the file and hide them via hs-hide-comment-region"
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "^[ \t]*#." (point-max) 3 )
    (let ((beg (line-beginning-position))
	  (count 1)
	  (end nil))
      (forward-line)
      (while (re-search-forward "^[ \t]*#." (line-end-position) 3 1) 
	(setq count (+ count 1))
	(forward-line)
	(setq end (line-end-position)))
      (if (> count 1)
	  (hs-hide-comment-region beg end))
      (forward-line count)
      )
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(provide 'dove-ext)

;(char-after)b (char-before)