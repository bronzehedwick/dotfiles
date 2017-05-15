
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

;; Set evil mode options
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump nil)

;; Require evil mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)

;; Require evil leader
(add-to-list 'load-path "~/.emacs.d/evil-leader")
(require 'evil-leader)

;; Enable evil leader and evil mode
(global-evil-leader-mode)
(evil-mode 1)

;; Remap leader to `,`
(evil-leader/set-leader ",")

;; Require evil org mode
(add-to-list 'load-path "~/.emacs.d/evil-org-mode")
(require 'evil-org)
