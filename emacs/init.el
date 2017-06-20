
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;; Require Org mode
(require 'org)

;; Org mode bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Org mode templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "" "Tasks")
	 "* TODO %?\n %i\n %a")
	("n" "Note" entry (file+headline "" "Notes")
	 "* %?\nentered on %U\n %i\n %^g")))

;; Org mode encryption
(setq epa-file-encrypt-to "bronzehedwick@gmail.com")

;; Change color scheme
(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-eighties)
