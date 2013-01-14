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
    hide-region
    psvn
;;     rinari
    (:name move-text
           :type emacswiki
           :features move-text)
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
            :build ("rm lisp/contrib/tabbar.el" "sed -i -e '/(global-set-key/d' lisp/pde-load.el" "perl Makefile.PL" "make")
            :load-path ("./lisp")
            :features pde-load)        
    (:name icicles
           :type git
           :url "git://github.com/emacsmirror/icicles.git"
           :features icicles
           :after (lambda() (icy-mode))
           )

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

))

(el-get)
;(el-get 'sync)
                            
