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
    auto-complete
;    auto-complete-yasnippet
;    awk-it
    csv-mode
    dired+
    dired-details
    diredful
    emacs-w3m
    helm
    hide-region
;    icicles
    linum+
    move-text
;    org-mode
    psvn
;    pymacs
    powerline
    tabbar
    tabbar-ruler
    tabbar-extension
;    yaml-mode


;    (:name oddmuse                  ; the mode used to edit Emacswiki pages
;           :type emacswiki
;           :features oddmuse
;           :after (lambda () 
;                    (setq oddmuse-username "DavidYoung")
;                    (setq oddmuse-wiki "EmacsWiki")))
;
    (:name org-7.9
           :typ http-tar
           :url "file:///home/dove/.emacs.d/org-7.9.3e.tar.gz"
           :options ("xzf")
           :info "org-7.9.3e/doc"
           :build ("cd org-7.9.3e" "make")
           :load-path ("org-7.9.3e" "org-7.9.3e/lisp" "org-7.9.3e/contrib/lisp")
           :features org-install)
     
     (:name Emacs-PDE
            :type http-tar
            :url "file:///home/dove/.emacs.d/Emacs-PDE-0.2.16.tar.gz"
            :options ("xzf")
            :info "./lisp/doc"
            :build ("sed -i -e '/(global-set-key/d' lisp/pde-load.el" "perl Makefile.PL" )
;            :build ("rm lisp/contrib/tabbar.el" "sed -i -e '/(global-set-key/d' lisp/pde-load.el" "perl Makefile.PL" "make")
            :load-path ("./lisp")
            :features pde-load)
    (:name icicles
           :type git
           :url "git://github.com/emacsmirror/icicles.git"
           :features icicles
           :after (progn (icy-mode))
           )
;;    (:name ropemode
;;           :type hg
;;           :url "https://bitbucket.org/agr/ropemode")
;
     (:name puppet-mode
            :type git 
            :url "https://github.com/puppetlabs/puppet-syntax-emacs.git"
            :features puppet-mode
            )
;    (:name puppet-flymake
;           :type git 
;           :url "https://github.com/grimradical/puppet-flymake.git"
;           :features flymake-puppet
;           :after (add-hook 'puppet-mode-hook (lambda () (flymake-puppet-load)))
;           )
;
;    (:name yasnippet
;           :type git
;           :url "https://github.com/capitaomorte/yasnippet.git"
;           :features yasnippet
;           :pkgname "capitaomorte/yasnippet"
;           :compile "yasnippet.el"
;           :after (progn
;                          (yas-global-mode 1))
;           )
;
))
;
(el-get)
;(el-get 'sync)
