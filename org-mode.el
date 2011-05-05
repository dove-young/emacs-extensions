
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-agenda-files (list "~/org/work.org" "~/org/home.org"))
;(add-hook 'org-mode-hook 'turn-on-font-lock) 
(org-remember-insinuate)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cr" 'org-remember)
(setq org-use-fast-todo-selection t)

;(setq org-indent-mode nil)
;(setq system-time-locale "C")
;(setq org-return-follows-link t)
;(require 'org-babel-init)

;(add-hook 'org-mode-hook
;	  (setq org-indent-mode nil))

;(define-key org-mode-map (kbd "C-c a") (quote org-agenda))

;(setq org-remember-templates
;       '(("Idea" ?i "* Ideas %U\n%?\n %i\n  %a" "~/org/home.org" "New Ideas")
;	 ("Journal" ?j "* %U \n%?\n\n  %i\n  %a" "~/org/home.org" date-tree)
;;	 ("ToDo" ?t "* TODO %^{Tasks to be remembered:} %U  %i\n  " "~/org/work.org" "Tasks to be remembered")
;	 ("ToDo" ?t "* TODO %^{Brief Description:} %^g\n%?\nAdded: %U" "~/org/work.org" "Tasks")
;	 )
;       )
;(setq org-feed-alist 
;      '(("SaCha Chua - Emacs" "http://sachachua.com/wp/category/emacs/feed/" 
;	 "~/org/rss.org" "Sacha Chua - Emacs")))


;(add-hook 'org-agenda-log-mode-hook
;(defcustom org-agenda-log-mode-items '(closed clock state scheduled)
;  "List of items that should be shown in agenda log mode.
;This list may contain the following symbols:
;
;  closed    Show entries that have been closed on that day.
;  clock     Show entries that have received clocked time on that day.
;  state     Show all logged state changes.
;Note that instead of changing this variable, you can also press `C-u l' in
;the agenda to display all available LOG items temporarily."
;  :group 'org-agenda-daily/weekly
;  :type '(set :greedy t (const closed) (const clock) (const state) (const scheduled)))
;)

(define-skeleton 6W
  "Input 6W into org-mode task"
""
"** Who?\n"
_"\n"
"** What?\n\n"
"** When?\n\n"
"** Where?\n\n"
"** Why?\n\n"
"** How?\n\n"
)

(define-skeleton 1exp 
  "Input #+BEGIN_EXAMPLE #+END_EXAMPLE in org-mode"
""
"#+BEGIN_EXAMPLE\n"
 _ "\n" 
"#+END_EXAMPLE"
)

(define-skeleton 1src 
  "Input #+begin_src #+end_src in org-mode"
""
"#+begin_src lisp \n"
 _ "\n" 
"#+end_src"
)

(define-skeleton 1prop 
  "Input :PROPERTIES: :END: in org-mode"
""
>":PROPERTIES:\n"
> _ "\n" 
>":END:"
)

(define-abbrev org-mode-abbrev-table "6W"  "" '6W)
(define-abbrev org-mode-abbrev-table "iexp" "" '1exp)
(define-abbrev org-mode-abbrev-table "isrc" "" '1src)
(define-abbrev org-mode-abbrev-table "iprop" "" '1prop)

(define-skeleton insert-emacser-code
  ""
  ""
  "#+BEGIN_HTML\n"
"<pre lang=\"lisp\" line=\"1\">\n"
_"\n"
"</pre>\n"
"#+END_HTML\n"
)

(define-abbrev org-mode-abbrev-table "ihtml"  "" 'insert-emacser-code)

;(require 'schedule)
(require 'remember)

;(defvar shell-mode-abbrev-table nil
;  "Abbrev table in use in `shell-mode' buffers.")
(define-abbrev-table 'shell-mode-abbrev-table ())

;; Add Shell mode Skeletons here

(define-skeleton add_App_Support 
  "Add application support to a Tivoli Enterprise Server"
""
"bin/itmcmd support -t " _ " -s NEW sy hd lz ux nt m6 mq qi mc\n"
)

(define-abbrev shell-mode-abbrev-table "addappsuppt" "" 'add_App_Support)

(define-skeleton def_listener 
  "Define a listener in a WMQ QMgr"
  ""
  "DEF LISTENER(LST) TRPTYPE(TCP) PORT(" _ ") CONTROL(QMGR)\n"
)

(define-abbrev shell-mode-abbrev-table "deflst" "" 'def_listener)

(define-skeleton def_clusrcvr
  "Define a Cluster Receiver Channel in a WMQ QMgr"
  ""
  "DEF CHL(TO.QMCOD.4.FTECA) CHLTYPE(CLUSRCVR) CONNAME('" _ "') CLUSTER(FTECA)\n"
)

(define-abbrev shell-mode-abbrev-table "defclusrcvr" "" 'def_clusrcvr)

(define-skeleton tivg11_defect_data
  "Define defect data path in tivg11"
  ""
  "/var/www/cgi-bin-" _ "/defectWeb/data"
)

(define-abbrev shell-mode-abbrev-table "tivg11data" "" 'tivg11_defect_data)

(define-skeleton kill-multiple-proces
  "Build killing multiple process command list"
  ""
  "ps -ef | grep -i " _ " | awk '{ print \"kill -9 \" $2 }'"
)

(define-abbrev shell-mode-abbrev-table "killps" "" 'kill-multiple-proces)

(define-skeleton gunzip-tar
  "unzip .tar.gz package in where -z is not available"
  ""
  "gunzip -cd " _ " | tar -xf - "
)

(define-abbrev shell-mode-abbrev-table "gunzipme" "" 'gunzip-tar)

(define-skeleton remote_deploy_km6
  ""
  ""
"bin/tacmd addsystem -t M6 -n " _ " -p \ 
COMMANDQM.KM6_QMCMD_CHANNEL=SYSTEM.DEF.SVRCONN \ 
COMMANDQM.KM6_QMCMD_CONNSTR='tivhpi03(3001)' \ 
COMMANDQM.KM6_QMCMD_NAME=QMCOD \ 
COORQM.KM6_QMCOOR_CHANNEL=SYSTEM.DEF.SVRCONN \ 
coorqm.KM6_QMCOOR_CONNSTR='tivhpi03(3001)' \ 
COORQM.KM6_QMCOOR_NAME=QMCOD INSTANCE=tivhpi03"
)

(define-abbrev shell-mode-abbrev-table "deploykm6" "" 'remote_deploy_km6)

(define-skeleton lskm6build
  ""
  ""
  "function lskm6build { "
"if [ ! -d /mnt/tivx09 ] "
"then "
"   mkdir /mnt/tivx09 "
"fi "
"if [ ! -d /mnt/tivx09/itcam4msg_fte_v701 ] "
"then "
"   mount tivx09.cn.ibm.com:/builds/images4scat /mnt/tivx09 "
"fi "
"ls /mnt/tivx09/itcam4msg_fte_v701 "
""
"}"
)
(define-abbrev shell-mode-abbrev-table "lskm6build" "" 'lsbuildfunc)



(define-skeleton define-kill-more
  ""
  ""
"function killmore {"
"ps -ef | grep $1 | awk '{ print \"kill -9 \" $2  }'"
"echo "
"ps -ef | grep $1"
"}"
)

(define-abbrev shell-mode-abbrev-table "def-killmore" "" 'define-kill-more)

(define-skeleton ssh-login
  ""
  ""
  "ssh root@" _ ".cn.ibm.com"
)

(define-abbrev shell-mode-abbrev-table "sshl" "" 'ssh-login)