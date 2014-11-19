;; include any files in list directory
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
  ("marmalade" . "http://marmalade-repo.org/packages/")
  ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Looping through a list of packages, may want to use use-package
;; http://stackoverflow.com/questions/21064916/auto-install-emacs-packages-with-melpa
(defvar camwes/packages
  '(sws-mode sass-mode scss-mode jade-mode haml-mode ruby-mode use-package php-mode stylus-mode coffee-mode google-maps soundcloud vagrant virtualenv xterm-color s w3 textmate mkdown markdown-mode nodejs-repl httpd  google google-maps grunt github-browse-file git-timemachine git-commit-mode evernote-mode emms editorconfig gitignore-mode gh gist f esqlite emamux git-messenger requirejs-mode reveal-in-finder git-rebase-mode ecb dash dirtree dockerfile-mode django-mode bitly bash-completion apt-utils bundler commander dropbox string-utils json-mode restclient regex-tool todotxt html-to-markdown hackernews))
(dolist (p camwes/packages)
  (if (not (package-installed-p p))
      (progn
        (package-refresh-contents)
        (package-install p)))
  (require p))
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;; Emacs Multimedia System
(emms-standard)
(emms-default-players)
;; Don't compile scss at save
(setq scss-compile-at-save nil)
;; for xterm
(xterm-mouse-mode 1)
;; load editorconfig
(load "editorconfig")
