
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Packages
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(package-selected-packages (quote (org))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Change color scheme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-eighties)

;;
;; Org Mode
;;

;; Bindings
(require 'org)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Todo Keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(f)" "DELEGATED(g)" "APPT(a)" "|" "DONE(d)" "DEFFERED(f)" "CANCELED(c)")))

;; Tags
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@art" . ?a))

;; Capture Templates
(setq org-capture-templates
      (quote (("t" "Todo" entry (file+headline (concat org-directory "/todos.org") "Tasks")
	       "* TODO %? %^g\n%^t\n%i")
	      ("n" "Note" entry (file+headline (concat org-directory "/notes.org") "Notes")
	       "* %?\n%U\n%i\n")
	      ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
	       "* %?\nEntered on %U\n%i\n"))))
