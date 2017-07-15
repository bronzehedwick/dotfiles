;;
;; Packages
;;

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

;;
;; General configurations
;;

;; Change color scheme
(require 'color-theme-sanityinc-tomorrow)

;; Reload buffer
(global-set-key [f5] '(lambda () (interactive) (revert-buffer nil t nil)))

;; Use spaces for all indentation
(setq-default indent-tabs-mode nil)

;; Save backup files to a common directory, instead of next to the original
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

;; Set fill column. Not exactly sure what this is.
(setq-default fill-column 72)

;; Auto wrap to new lines when reaching column limit
(setq auto-fill-mode 1)

;; New buffers should default to text, instead of fundamental
(setq default-major-mode 'text-mode)

;; Highlight the current line
(global-hl-line-mode 1)

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

;; Agenda files
(setq org-agenda-files (list "~/org"))

;; Todo Keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(f)" "DELEGATED(g)" "APPT(a)" "|" "DONE(d)" "DEFFERED(f)" "CANCELED(c)")))

;; Tags
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@lunch" . ?l) ("errand" . ?e) ("art" . ?a)))

;; Capture Templates
(setq org-capture-templates
      (quote (("t" "Todo" entry (file+headline (concat org-directory "/todos.org") "Tasks")
               "* TODO %?\nEntered on %U\n%i\n")
              ("n" "Note" entry (file+headline (concat org-directory "/notes.org") "Notes")
               "* %?\nEntered on %U\n%i\n")
              ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
               "* Morning page\nEntered on %U\n%i\n%?\n"))))

;;
;; Olivetti (writing)
;;

(require 'olivetti)
(use-package olivetti
  :config
  (setq-default
   olivetti-hide-mode-line t
   olivetti-body-width 66))

;;
;; Fountain (screenwriting)
;;

(require 'fountain-mode)
