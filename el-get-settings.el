;;; el-get-settings.el --- package management through el-get

;; Copyright (C) 2011 Free Software Foundation, Inc.
;;
;; Author: dove <dove@dove-ThinkPad-T400>
;; Maintainer: dove <dove@dove-ThinkPad-T400>
;; Created: 22 May 2011
;; Version: 0.01
;; Keywords: el-get package extension


;; So the idea is that you copy/paste this code into your *scratch* buffer,
;; hit C-j, and you have a working el-get.
(unless (require 'el-get nil t)
 (url-retrieve
  "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
  (lambda (s)
    (end-of-buffer)
    (eval-print-last-sexp))))
 
(require 'el-get)

(setq
  el-get-sources
  '(el-get
;;     auctex
;; ;    auto-complete
;; ;    anything
;; ;    anything-config
;; ;    anything-complete
;; ;    anything-grep
;;     basic-mode
;;     browse-kill-ring
;;     buffer-move
;;     bookmark+
;; ;    crontab-mode
;;     css-mode
;; ;    csv-mode
;    dired-details
;    dired-details%2b
;    simple-call-tree
;    whitespace
;    flymake-ruby
    org-mode
    tabbar-ruler
    yaml-mode
;     (:name dired%2b 
;            :type emacswiki
;            :load ("dired%2b.el"))
;; ;    dired%2b    ; icicles depends on this package
;; ;    nxhtml
;; ;    ecb
     hide-region
;;     magit
;;     tabbar
     psvn
;;     rinari

;     switch-window
;;     yasnippet
;;     (:name menu-bar+
;;            :type emacswiki
;;            :features menu-bar+)
;;     (:name dired-sort-menu
;;            :type emacswiki
;; n           :features dired-sort-menu)
;; ;    dired-sort-menu+
;;     (:name dired-sort
;;            :type emacswiki
;;            :features dired-sort)
;;     (:name session
;;            :post-init (lambda () (add-hook 'after-init-hook 'session-initialize)))
;;  ;   (:name emacs-w3m
;;  ;          :type emacswiki
;;  ;          :features w3m-load
;;  ;          :after mime-w3m)
;; ;    (:name rfc
;; ;           :type emacswiki
;; ;           :build ("sed -i -e 's/ (require.*w3)/;&/' rfc.el")
;; ;           :features rfc
;; ;           :load ("../../rfcview.el")
;; ;           :after (lambda () 
;; ;                    (setq rfc-url-save-directory "~/rfc")
;; ;                    (setq rfc-index-url "http://www.ietf.org/rfc/rfc-index.txt")
;; ;                    (setq rfc-archive-alist (list (concat rfc-url-save-directory "/rfc.zip")
;; ;                                                  rfc-url-save-directory
;; ;                                                  "http://www.ietf.org/rfc/"))
;; ;                    (setq rfc-insert-content-url-hook '(rfc-url-save))
;; ;                    (add-hook 'rfc-index-mode-hook 'rfcview-mode)))
;; ;
     (:name move-text
            :type emacswiki
            :features move-text)
 
;;    (:name orgmode
;;           :type http-tar
;;           :url "file:///home/dove/.emacs.d/org-7.9.2.tar.gz"
;;           :options ("-xzf")
;;           :info "./org-7.9.2/doc"
;;           :build ("cd ./org-7.9.2; make")
;;           :load-path ("./org-7.9.2/lisp")
;;           :features org-install)
;; 
;; ;    (:name haskell-mode
;; ;         :type http-tar
;; ;         :options ("xzf")
;; ;         :url "file:///home/dove/.emacs.d/haskell-mode-2.8.0.tar.gz"
;; ;;         :url "http://projects.haskell.org/haskellmode-emacs/haskell-mode-2.8.0.tar.gz"
;; ;         :load "haskell-site-file.el"
;; ;         :after (lambda ()
;; ;                  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; ;                  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)))
;;     (:name oddmuse                  ; the mode used to edit Emacswiki pages
;;            :type emacswiki
;;            :features oddmuse
;;            :after (lambda () 
;;                     (setq oddmuse-username "DavidYoung")
;;                     (setq oddmuse-wiki "EmacsWiki")))
;; 
     (:name Emacs-PDE
            :type http-tar
            :url "file:///home/dove/.emacs.d/Emacs-PDE-0.2.16.tar.gz"
            :options ("xzf")
            :info "./lisp/doc"
            :build ("rm lisp/contrib/tabbar.el" "sed -i -e '/(global-set-key/d' lisp/pde-load.el" "perl Makefile.PL" "make")
            :load-path ("./lisp")
            :features pde-load)        
    (:name icicles
           :type git
           :url "git://github.com/emacsmirror/icicles.git"
           :features icicles
           :after (lambda() (icy-mode))
           )
;      (:name hexrgb
;             :type emacswiki
;             :features hexrgb)
;     (:name sunrise-commander-github
;            :type git
;            :url "git://github.com/escherdragon/sunrise-commander.git"
;            :features sunrise-commander
;            )

     (:name puppet-mode
            :type git 
            :url "https://github.com/puppetlabs/puppet-syntax-emacs.git"
            :features puppet-mode
            )
    (:name puppet-flymake
           :type git 
           :url "https://github.com/grimradical/puppet-flymake.git"
           :features flymake-puppet
           :after (add-hook 'puppet-mode-hook (lambda () (flymake-puppet-load)))
           )
;; ;    (:name cedet
;; ;           :type bzr
;; ;           :url "bzr://cedet.bzr.sourceforge.net/bzrroot/cedet/code/trunk"
;; ;           :build ("make")
;; ;           :features cedet
;; ;           :load-path ("./common" "./semantic")
;; ;           :post-init (lambda () (global-ede-mode 1))
;; ;           )
))

(el-get)
;(el-get 'sync)
                            
