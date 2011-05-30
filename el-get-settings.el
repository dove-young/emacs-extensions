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
    basic-mode
;    crontab-mode
;    csv-mode
    tabbar
    psvn
    switch-window
    yasnippet
    hide-region
    (:name emacs-w3m
           :type emacswiki
           :features w3m-load
           :after mime-w3m)
    (:name rfc
           :type emacswiki
           :build ("sed -i -e 's/ (require.*w3)/;&/' rfc.el")
           :features rfc
           :load ("../../rfcview.el")
           :after (lambda () 
                    (setq rfc-url-save-directory "~/rfc")
                    (setq rfc-index-url "http://www.ietf.org/rfc/rfc-index.txt")
                    (setq rfc-archive-alist (list (concat rfc-url-save-directory "/rfc.zip")
                                                  rfc-url-save-directory
                                                  "http://www.ietf.org/rfc/"))
                    (setq rfc-insert-content-url-hook '(rfc-url-save))
                    (add-hook 'rfc-index-mode-hook 'rfcview-mode)))

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
           :after (lambda () 
                    (setq oddmuse-username "DavidYoung")
                    (setq oddmuse-wiki "EmacsWiki")))

    (:name Emacs-PDE
           :type http-tar
           :url "file:///home/dove/.emacs.d/Emacs-PDE-0.2.16.tar.gz"
           :options ("xzf")
           :info "./lisp/doc"
           :build ("mv lisp/contrib/tabbar.el{,.bak}" "sed -i -e '/(global-set-key/d' lisp/pde-load.el" "perl Makefile.PL" "make")
           :load-path ("./lisp")
           :features pde-load)        
    (:name icicles
           :type git
           :url "git://github.com/emacsmirror/icicles.git"
           :features icicles
;           :after (lambda() (icy-mode))
           )
    (:name hexrgb
           :type emacswiki
           :features hexrgb)
))

;(el-get 'sync)
(el-get)
                            
