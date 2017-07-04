;; Packages
(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(package-selected-packages (quote (color-theme-sanityinc-tomorrow org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Change color scheme
(require 'color-theme-sanityinc-tomorrow)

;; Reload buffer
(global-set-key [f5] '(lambda () (interactive) (revert-buffer nil t nil)))

;;
;; Org Mode
;;

(require 'org)

;; Bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Defaults
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; Todo Keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(f)" "DELEGATED(g)" "APPT(a)" "|" "DONE(d)" "DEFFERED(f)" "CANCELED(c)")))

;; Tags
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@art" . ?a)))

;; Capture Templates
(setq org-capture-templates
      (quote (("t" "Todo" entry (file+headline (concat org-directory "/todos.org") "Tasks")
               "* TODO %? %^g\n%^t\n%i")
              ("n" "Note" entry (file+headline (concat org-directory "/notes.org") "Notes")
               "* %?\n%U\n%i\n")
              ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
               "* %?\nEntered on %U\n%i\n"))))
