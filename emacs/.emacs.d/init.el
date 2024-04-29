(add-to-list 'default-frame-alist '(font . "SF Mono-18"))
(set-face-attribute 'default t :font "SF Mono-18")

;; Show stray whitespace.
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; Consider a period followed by a single space to be end of sentence.
(setq sentence-end-double-space nil)

;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; Display the distance between two tab stops as 4 characters wide.
(setq-default tab-width 4)

;; Indentation setting for various languages.
(setq c-basic-offset 4)
(setq js-indent-level 2)
(setq css-indent-offset 2)

;; Highlight matching pairs of parentheses.
(setq show-paren-delay 0)
(show-paren-mode)

;; Write auto-saves and backups to separate directory.
(make-directory "~/.local/share/emacs/auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/.local/share/emacs/auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.local/share/emacs/backup/")))

;; Do not move the current file while creating backup.
(setq backup-by-copying t)

;; Disable lockfiles.
(setq create-lockfiles nil)

;; Workaround for https://debbugs.gnu.org/34341 in GNU Emacs <= 26.3.
(when (and (version< emacs-version "26.3") (>= libgnutls-version 30603))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Write customizations to a separate file instead of this file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

;; Custom command.
(defun show-current-time ()
  "Show current time."
  (interactive)
  (message (current-time-string)))

;; Custom key sequences.
(global-set-key (kbd "C-c t") 'show-current-time)
(global-set-key (kbd "C-c d") 'delete-trailing-whitespace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/Documents/org/random.org" "~/Documents/org/journal.org" "~/Documents/org/projects.org" "~/Documents/org/index.org" "~/Documents/org/books.org" "~/Documents/org/bits.org" "~/Documents/org/refile.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun my/org-find-previous-workday ()
  (let* ((time (time-subtract (current-time) (seconds-to-time 86400)))
         (workdays '("Monday" "Tuesday" "Wednesday" "Thursday" "Friday")))
    (while (not (member (format-time-string "%A" time) workdays))
           (setq time (time-subtract time (seconds-to-time 86400))))
    time))

(defun my/org-should-include-current (level)
  (progn
    (if (and
          (outline-on-heading-p)
          (or
            (eq nil level) (eq level (org-outline-level))))
      t
      nil)))
(defun my/org-get-current-header ()
  (progn
    (setq beg (point))
    (outline-end-of-heading)
    (buffer-substring-no-properties beg (point))))
(defun my/org-outline-headings-to-list (level)
  (setq headings '())
  (show-all)
  (goto-char (point-min))
  (if (my/org-should-include-current level)
    (add-to-list 'headings (my/org-get-current-header) t))
  (while (outline-next-heading)
         (if (my/org-should-include-current level)
           (add-to-list 'headings (my/org-get-current-header) t)))
  headings)

(defun my/org-outline-create-scrum-message ()
  (interactive)
  (let* ((previous (my/org-find-previous-workday)))
    (setq journal-file (concat org-journal-dir (format-time-string "%Y%m%d" previous)))
    (if (file-exists-p journal-file)
      (progn
        (switch-to-buffer (find-file-noselect journal-file))
        (setq headings (my/org-outline-headings-to-list 2))
        (switch-to-buffer "*daily scrum*")
        (erase-buffer)
        (insert "* Yesterday\n")
        (mapcar (lambda(element)
                  (insert (replace-regexp-in-string "^** ..... " "  - " element) "\n")) headings)
        (insert "\n* Today\n  - ")
        (org-mode)
        (show-all)))))

(setq org-directory "~/Documents/org")
(setq org-default-notes-file (concat org-directory "/refile.org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file org-default-notes-file)
         "* TODO %?\n%u")
        ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
         "* %<%X>\n%?")))

;; Orgmode mappings
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Auto dark mode package
(add-to-list 'load-path "~/.emacs.d/auto-dark/")
(require 'auto-dark)
(auto-dark-mode t)
