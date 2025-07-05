;;; afternoon-theme.el --- Dark color theme with a deep blue background -*- lexical-binding: t; -*-

;; Copyright (C) 2013 Ozan Sener

;; Author: Ozan Sener <ozan@ozansener.com>
;; Keywords: faces
;; URL: https://github.com/KarimAziev/emacs-afternoon-theme
;; Version: 0.1
;; Package-Requires: ((emacs "26.1"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; To use it, put the following in your Emacs configuration file:
;;
;;   (load-theme 'afternoon t)
;;
;; Requirements: Emacs 24.

;;; Credits:

;; Colour selection by Chris Kempson and Scott Frazer:
;; https://github.com/ChrisKempson/Tomorrow-Theme
;; https://github.com/scfrazer/.emacs.d/blob/master/themes/deeper-blue-theme.el

;; Based on Steve Purcell's "color-theme-sanityinc-tomorrow" theme.
;; https://github.com/purcell/color-theme-sanityinc-tomorrow/

;;; Code:

(deftheme afternoon
  "Dark color theme with a deep blue background.")

(defvar afternoon-default-colors '((background . "#181a26")
                                   (current-line . "#14151E")
                                   (block-background . "#1F2232")
                                   (selection . "#103050")
                                   (foreground . "#eaeaea")
                                   (comment . "#969896")
                                   (red . "#d54e53")
                                   (orange . "goldenrod")
                                   (yellow . "#e7c547")
                                   (green . "SeaGreen2")
                                   (aqua . "#6363b8b8ffff")
                                   (blue . "DeepSkyBlue1")))


(defcustom afternoon-custom-colors afternoon-default-colors
  "Specify a list of custom colors."
  :type `(alist
          :key-type (choice :tag "Name"
                            ,@(mapcar (lambda (it)
                                        (list 'const :tag
                                              (capitalize (symbol-name (car
                                                                        it)))
                                              (car it)))
                                      afternoon-default-colors))
          :value-type color)
  :group 'afternoon)

(add-variable-watcher 'afternoon-custom-colors
                      #'afternoon-colors-watcher)

(defun afternoon-colors-watcher (_symbol newval _operation _buffer)
  "Variable watcher to update afternoon theme with colors NEWVAL."
  (afternoon-create-theme newval))

(defun afternoon-create-theme (&optional colors-alist)
  "Create afternoon theme.
Default value of COLORS-ALIST is `afternoon-custom-colors'."
  (let ((class '((class color)
                 (min-colors 89)))
        (256color (eq (display-color-cells (selected-frame)) 256)))
    (let ((background (if 256color "#1c1c1c" "#181a26"))
          (current-line (if 256color "#121212" "#14151E"))
          (block-background (if 256color "#262626" "#1F2232"))
          (selection "#103050")
          (foreground "#eaeaea")
          (comment "#969896")
          (red "#d54e53")
          (orange "goldenrod")
          (yellow "#e7c547")
          (green "SeaGreen2")
          (aqua "#6363b8b8ffff")
          (blue "DeepSkyBlue1")
          (purple "#c397d8"))
      (dolist (cell (or colors-alist afternoon-custom-colors))
        (set (car cell)
             (cdr cell)))
      (custom-theme-set-faces
       'afternoon
       `(default ((,class (:background ,background
                           :foreground ,foreground
                           :height 100))))
       `(bold ((,class (:weight bold))))
       `(bold-italic ((,class (:slant italic
                               :weight bold))))
       `(underline ((,class (:underline t))))
       `(italic ((,class (:slant italic))))
       `(font-lock-builtin-face ((,class (:foreground "LightCoral"))))
       `(font-lock-comment-delimiter-face ((,class (:foreground ,comment))))
       `(font-lock-comment-face ((,class (:foreground ,comment))))
       `(font-lock-constant-face ((,class (:foreground ,yellow))))
       `(font-lock-doc-face ((,class (:foreground "moccasin"))))
       `(font-lock-doc-string-face ((,class (:foreground ,yellow))))
       `(font-lock-function-name-face ((,class (:foreground ,orange))))
       `(font-lock-keyword-face ((,class (:foreground ,blue))))
       `(font-lock-negation-char-face ((,class (:foreground ,blue))))
       `(font-lock-preprocessor-face ((,class (:foreground "gold"))))
       `(font-lock-regexp-grouping-backslash ((,class (:foreground ,yellow))))
       `(font-lock-regexp-grouping-construct ((,class (:foreground ,purple))))
       `(font-lock-string-face ((,class (:foreground "burlywood"))))
       `(font-lock-type-face ((,class (:foreground "#ffffd7d70000"))))
       `(font-lock-variable-name-face ((,class (:foreground ,yellow))))
       `(font-lock-warning-face ((,class (:weight bold
                                          :foreground ,red))))
       `(shadow ((,class (:foreground ,comment))))
       `(success ((,class (:foreground "SeaGreen2"))))
       `(error ((,class (:foreground ,red))))
       `(warning ((,class (:foreground ,orange))))
       ;; company
       ;; Flycheck
       `(flycheck-error ((,class (:underline (:style wave
                                              :color ,red)))))
       `(flycheck-warning ((,class (:underline (:style wave
                                                :color ,orange)))))
       ;; Clojure errors
       `(clojure-test-failure-face
         ((,class (:background unspecified
                   :inherit flymake-warning))))
       `(clojure-test-error-face ((,class (:background unspecified
                                           :inherit flymake-error))))
       `(clojure-test-success-face ((,class (:background unspecified
                                             :foreground unspecified
                                             :underline ,green))))
       ;; EDTS errors
       `(edts-face-warning-line ((t (:background unspecified
                                     :inherit flymake-warning))))
       `(edts-face-warning-mode-line ((,class (:background unspecified
                                               :foreground ,orange
                                               :weight bold))))
       `(edts-face-error-line ((t (:background unspecified
                                   :inherit flymake-error))))
       `(edts-face-error-mode-line ((,class (:background unspecified
                                             :foreground ,red
                                             :weight bold))))
       ;; For Brian Carper's extended clojure syntax table
       `(clojure-keyword ((,class (:foreground ,yellow))))
       `(clojure-parens ((,class (:foreground ,foreground))))
       `(clojure-braces ((,class (:foreground ,green))))
       `(clojure-brackets ((,class (:foreground ,yellow))))
       `(clojure-double-quote ((,class (:foreground ,aqua
                                        :background unspecified))))
       `(clojure-special ((,class (:foreground ,blue))))
       `(clojure-java-call ((,class (:foreground ,purple))))
       ;; Rainbow-delimiters
       `(rainbow-delimiters-depth-1-face ((,class (:foreground ,foreground))))
       `(rainbow-delimiters-depth-2-face ((,class (:foreground ,aqua))))
       `(rainbow-delimiters-depth-3-face ((,class (:foreground ,yellow))))
       `(rainbow-delimiters-depth-4-face ((,class (:foreground ,green))))
       `(rainbow-delimiters-depth-5-face ((,class (:foreground ,blue))))
       `(rainbow-delimiters-depth-6-face ((,class (:foreground ,foreground))))
       `(rainbow-delimiters-depth-7-face ((,class (:foreground ,aqua))))
       `(rainbow-delimiters-depth-8-face ((,class (:foreground ,yellow))))
       `(rainbow-delimiters-depth-9-face ((,class (:foreground ,green))))
       `(rainbow-delimiters-unmatched-face ((,class (:foreground ,red))))
       ;; MMM-mode
       `(mmm-code-submode-face ((,class (:background ,current-line))))
       `(mmm-comment-submode-face ((,class (:inherit font-lock-comment-face))))
       `(mmm-output-submode-face ((,class (:background ,current-line))))
       ;; Search
       `(match ((,class (:background "steelblue4"
                         :underline "steelblue4"))))
       `(isearch ((,class (:foreground ,yellow
                           :background ,background
                           :inverse-video t))))
       `(lazy-highlight ((,class (:foreground ,aqua
                                  :background ,background
                                  :inverse-video t))))
       `(isearch-fail ((,class (:background ,background
                                :inherit font-lock-warning-face
                                :inverse-video t))))
       ;; Anzu
       `(anzu-mode-line ((,class (:foreground ,orange))))
       `(anzu-replace-highlight ((,class (:inherit lazy-highlight))))
       `(anzu-replace-to ((,class (:inherit isearch))))
       ;; iedit
       `(iedit-occurrence ((,class (:inverse-video t))))
       ;; ivy
       `(ivy-highlight-face ((,class (:foreground ,orange
                                      :background unspecified))))
       `(ivy-minibuffer-match-highlight ((,class (:weight bold
                                                  :background
                                                  unspecified))))
       `(ivy-yanked-word ((,class (:foreground ,yellow
                                   :background unspecified))))
       ;; ivy-cursor
       ;; IDO
       `(ido-subdir ((,class (:foreground ,purple))))
       `(ido-first-match ((,class (:foreground ,orange))))
       `(ido-only-match ((,class (:foreground ,green))))
       `(ido-indicator ((,class (:foreground ,red
                                 :background ,background))))
       `(ido-virtual ((,class (:foreground ,comment))))
       ;; flx-ido
       `(flx-highlight-face ((,class (:inherit nil
                                      :foreground ,yellow
                                      :weight bold
                                      :underline nil))))
       ;; vertico
       `(vertico-current ((,class (:foreground "black"
                                   :background "#65a7e2"
                                   :extend t))))
       `(completions-common-part ((,class (:foreground "GhostWhite"
                                           :background "#555555"
                                           :weight bold))))
       ;; which-function
       `(which-func ((,class (:foreground ,blue
                              :background unspecified))))
       ;; Emacs interface
       `(cursor ((,class (:background ,red))))
       `(fringe ((,class (:background ,current-line))))
       `(linum ((,class (:background ,current-line
                         :foreground ,green))))
       `(border ((,class (:background ,current-line))))
       `(border-glyph ((,class (nil))))
       `(highlight ((,class (:inverse-video t))))
       `(gui-element ((,class (:background ,current-line
                               :foreground ,foreground))))
       `(mode-line ((t (:background "black"
                        :box nil
                        :weight bold
                        :family "Lucida Grande"))))
       `(mode-line-highlight ((,class (:foreground "purple1"
                                       :box nil))))
       `(mode-line-inactive ((,class (:inherit mode-line
                                      :background "gray7"
                                      :foreground "dark gray"
                                      :box nil
                                      :weight bold))))
       `(mode-line-emphasis ((,class (:foreground ,foreground
                                      :slant italic))))
       `(minibuffer-prompt ((,class (:foreground ,blue))))
       `(region ((,class (:background ,selection
                          :foreground "gold"))))
       `(secondary-selection ((,class (:background ,current-line))))
       `(header-line ((,class (:inherit mode-line
                               :foreground ,purple
                               :background unspecified))))
       `(trailing-whitespace ((,class (:foreground ,red
                                       :inverse-video t
                                       :underline nil))))
       `(whitespace-trailing ((,class (:foreground ,red
                                       :inverse-video t
                                       :underline nil))))
       `(whitespace-space-after-tab ((,class (:foreground ,red
                                              :inverse-video t
                                              :underline nil))))
       `(whitespace-space-before-tab ((,class (:foreground ,red
                                               :inverse-video t
                                               :underline nil))))
       `(whitespace-empty ((,class (:foreground ,red
                                    :inverse-video t
                                    :underline nil))))
       `(whitespace-line ((,class (:background unspecified
                                   :foreground ,red))))
       `(whitespace-indentation ((,class (:background unspecified
                                          :foreground ,aqua))))
       `(whitespace-space ((,class (:background unspecified
                                    :foreground ,selection))))
       `(whitespace-newline ((,class (:background unspecified
                                      :foreground ,selection))))
       `(whitespace-tab ((,class (:background unspecified
                                  :foreground ,selection))))
       `(whitespace-hspace ((,class (:background unspecified
                                     :foreground ,selection))))
       ;; Parenthesis matching (built-in)
       `(show-paren-match-face ((,class (:background "dodgerblue1"
                                         :foreground "white"))))
       `(show-paren-mismatch-face ((,class (:background "red1"
                                            :foreground "white"))))
       ;; Smartparens paren matching
       `(sp-show-pair-match-face
         ((,class
           (:foreground unspecified
            :background unspecified
            :inherit show-paren-match))))
       `(sp-show-pair-mismatch-face ((,class (:foreground unspecified
                                              :background
                                              unspecified
                                              :inherit
                                              show-paren-mismatch))))
       ;; Parenthesis matching (mic-paren)
       `(paren-face-match ((,class (:foreground unspecified
                                    :background unspecified
                                    :inherit show-paren-match))))
       `(paren-face-mismatch
         ((,class (:foreground unspecified
                   :background unspecified
                   :inherit show-paren-mismatch))))
       `(paren-face-no-match
         ((,class (:foreground unspecified
                   :background unspecified
                   :inherit show-paren-mismatch))))
       ;; Parenthesis dimming (parenface)
       `(paren-face ((,class (:foreground ,comment
                              :background unspecified))))
       `(sh-heredoc ((,class (:foreground unspecified
                              :inherit font-lock-string-face
                              :weight normal))))
       `(sh-quoted-exec
         ((,class (:foreground unspecified
                   :inherit font-lock-preprocessor-face))))
       `(slime-highlight-edits-face ((,class (:weight bold))))
       `(slime-repl-input-face ((,class (:weight normal
                                         :underline nil))))
       `(slime-repl-prompt-face ((,class (:underline nil
                                          :weight bold
                                          :foreground ,purple))))
       `(slime-repl-result-face ((,class (:foreground ,green))))
       `(slime-repl-output-face ((,class (:foreground ,blue
                                          :background ,background))))
       `(csv-separator-face ((,class (:foreground ,orange))))
       `(diff-added ((,class (:foreground ,green))))
       `(diff-changed ((,class (:foreground ,purple))))
       `(diff-removed ((,class (:foreground ,orange))))
       `(diff-header ((,class (:foreground ,aqua
                               :background unspecified))))
       `(diff-file-header ((,class (:foreground ,blue
                                    :background unspecified))))
       `(diff-hunk-header ((,class (:foreground ,purple))))
       `(diff-refine-added ((,class (:inherit diff-added
                                     :inverse-video t))))
       `(diff-refine-removed ((,class (:inherit diff-removed
                                       :inverse-video t))))
       `(ediff-even-diff-A ((,class (:foreground unspecified
                                     :background unspecified
                                     :inverse-video t))))
       `(ediff-even-diff-B ((,class (:foreground unspecified
                                     :background unspecified
                                     :inverse-video t))))
       `(ediff-odd-diff-A  ((,class (:foreground ,comment
                                     :background unspecified
                                     :inverse-video t))))
       `(ediff-odd-diff-B  ((,class (:foreground ,comment
                                     :background unspecified
                                     :inverse-video t))))
       ;; macrostep
       `(macrostep-expansion-highlight-face ((,class (:foreground unspecified))))
       ;; undo-tree
       `(undo-tree-visualizer-default-face ((,class (:foreground ,foreground))))
       `(undo-tree-visualizer-current-face ((,class (:foreground ,green
                                                     :weight bold))))
       `(undo-tree-visualizer-active-branch-face ((,class (:foreground ,red))))
       `(undo-tree-visualizer-register-face ((,class (:foreground ,yellow))))
       ;; dired+
       `(diredfl-dir-name ((,class (:background "#2C2C2C2C2C2C"
                                    :foreground "lawn green"))))
       `(diredp-compressed-file-suffix ((,class (:foreground ,blue))))
       `(diredp-deletion ((,class (:inherit error
                                   :inverse-video t))))
       `(diredp-deletion-file-name ((,class (:inherit error))))
       `(diredp-dir-heading ((,class (:foreground ,green
                                      :weight bold))))
       `(diredp-dir-priv ((,class (:foreground ,aqua
                                   :background unspecified))))
       `(diredp-exec-priv ((,class (:foreground ,blue
                                    :background unspecified))))
       `(diredp-executable-tag ((,class (:foreground ,red
                                         :background unspecified))))
       `(diredp-file-name ((,class (:foreground ,yellow))))
       `(diredp-file-suffix ((,class (:foreground ,green))))
       `(diredp-flag-mark ((,class (:inverse-video t))))
       `(diredp-flag-mark-line ((,class (:background unspecified
                                         :inherit highlight))))
       `(diredp-ignored-file-name ((,class (:foreground ,comment))))
       `(diredp-link-priv ((,class (:background unspecified
                                    :foreground ,purple))))
       `(diredp-mode-line-flagged ((,class (:foreground ,red))))
       `(diredp-mode-line-marked ((,class (:foreground ,green))))
       `(diredp-no-priv ((,class (:background unspecified))))
       `(diredp-number ((,class (:foreground ,yellow))))
       `(diredp-other-priv ((,class (:background unspecified
                                     :foreground ,purple))))
       `(diredp-rare-priv ((,class (:foreground ,red
                                    :background unspecified))))
       `(diredp-read-priv ((,class (:foreground ,green
                                    :background unspecified))))
       `(diredp-symlink ((,class (:foreground "#000068688b8b"))))
       `(diredp-write-priv ((,class (:foreground ,yellow
                                     :background unspecified))))
       ;; Magit (a patch is pending in magit to make these standard upstream)
       `(magit-branch ((,class (:foreground ,green))))
       `(magit-diff-add ((,class (:inherit diff-added))))
       `(magit-diff-del ((,class (:inherit diff-removed))))
       `(magit-header ((,class (:inherit nil
                                :weight bold))))
       `(magit-item-highlight ((,class (:inherit highlight
                                        :background "#0000fafa9a9a"))))
       `(magit-log-author ((,class (:foreground ,aqua))))
       `(magit-log-graph ((,class (:foreground ,comment))))
       `(magit-log-head-label-bisect-bad ((,class (:foreground ,red))))
       `(magit-log-head-label-bisect-good ((,class (:foreground ,green))))
       `(magit-log-head-label-default ((,class (:foreground ,yellow
                                                :box nil
                                                :weight bold))))
       `(magit-log-head-label-local ((,class (:foreground ,purple
                                              :box nil
                                              :weight bold))))
       `(magit-log-head-label-remote ((,class (:foreground ,purple
                                               :box nil
                                               :weight bold))))
       `(magit-log-head-label-tags ((,class (:foreground ,aqua
                                             :box nil
                                             :weight bold))))
       `(magit-log-sha1 ((,class (:foreground ,yellow))))
       `(magit-section-title ((,class (:foreground ,blue
                                       :weight bold))))
       ;; git-gutter
       `(git-gutter:modified ((,class (:foreground ,purple
                                       :weight bold))))
       `(git-gutter:added ((,class (:foreground ,green
                                    :weight bold))))
       `(git-gutter:deleted ((,class (:foreground ,red
                                      :weight bold))))
       `(git-gutter:unchanged ((,class (:background ,yellow))))
       ;; git-gutter-fringe
       `(git-gutter-fr:modified ((,class (:foreground ,purple
                                          :weight bold))))
       `(git-gutter-fr:added ((,class (:foreground ,green
                                       :weight bold))))
       `(git-gutter-fr:deleted ((,class (:foreground ,red
                                         :weight bold))))
       `(link ((,class (:foreground ,blue
                        :underline t
                        :weight bold))))
       `(widget-button ((,class (:underline t))))
       `(widget-field
         ((,class
           (:background "VioletRed4"
            :foreground "LightGoldenrod"
            :box
            (:line-width (3 . 1)
             :color "black"
             :style flat-button)))))
       ;; Compilation (most faces politely inherit from 'success, 'error, 'warning etc.)
       `(compilation-column-number ((,class (:foreground ,yellow))))
       `(compilation-line-number ((,class (:foreground ,yellow))))
       `(compilation-message-face ((,class (:foreground ,blue))))
       `(compilation-mode-line-exit ((,class (:foreground ,green))))
       `(compilation-mode-line-fail ((,class (:foreground ,red))))
       `(compilation-mode-line-run ((,class (:foreground ,blue))))
       ;; Grep
       `(grep-context-face ((,class (:foreground ,comment))))
       `(grep-error-face ((,class (:foreground ,red
                                   :weight bold
                                   :underline t))))
       `(grep-hit-face ((,class (:foreground ,blue))))
       `(grep-match-face ((,class (:foreground unspecified
                                   :background unspecified
                                   :inherit match))))
       `(regex-tool-matched-face ((,class (:foreground unspecified
                                           :background unspecified
                                           :inherit match))))
       ;; mark-multiple
       `(mm/master-face ((,class (:inherit region
                                  :foreground unspecified
                                  :background unspecified))))
       `(mm/mirror-face ((,class (:inherit region
                                  :foreground unspecified
                                  :background unspecified))))
       `(org-agenda-structure ((,class (:foreground ,purple))))
       `(org-agenda-date ((,class (:foreground ,blue
                                   :underline nil))))
       `(org-agenda-done ((,class (:foreground ,green))))
       `(org-agenda-dimmed-todo-face ((,class (:foreground ,comment))))
       `(org-block ((,class (:foreground ,orange))))
       `(org-block-background ((,class (:background ,block-background))))
       `(org-code ((,class (:foreground ,yellow))))
       `(org-column ((,class (:background ,current-line))))
       `(org-column-title ((,class (:inherit org-column
                                    :weight bold
                                    :underline t))))
       `(org-date ((,class (:foreground ,blue
                            :underline t))))
       `(org-document-info ((,class (:foreground ,aqua))))
       `(org-document-info-keyword ((,class (:foreground ,green))))
       `(org-document-title ((,class (:weight bold
                                      :foreground ,orange
                                      :height 1.44))))
       `(org-done ((,class (:foreground ,green))))
       `(org-ellipsis ((,class (:foreground ,comment))))
       `(org-footnote ((,class (:foreground ,aqua))))
       `(org-formula ((,class (:foreground ,red))))
       `(org-hide ((,class (:foreground ,background
                            :background ,background))))
       `(org-link ((,class (:foreground ,blue
                            :underline t))))
       `(org-scheduled ((,class (:foreground ,green))))
       `(org-scheduled-previously ((,class (:foreground ,orange))))
       `(org-scheduled-today ((,class (:foreground ,green))))
       `(org-special-keyword ((,class (:foreground ,orange))))
       `(org-table ((,class (:foreground ,purple))))
       `(org-todo ((,class (:foreground ,red))))
       `(org-upcoming-deadline ((,class (:foreground ,orange))))
       `(org-warning ((,class (:weight bold
                               :foreground ,red))))
       `(markdown-url-face ((,class (:inherit link))))
       `(markdown-link-face ((,class (:foreground ,blue
                                      :underline t))))
       `(hl-sexp-face ((,class (:background ,current-line))))
       `(highlight ((,class (:inverse-video t
                             :background ,current-line))))
       `(hl-line ((,class (:extend t
                           :weight bold))))
       `(highlight-symbol-face ((,class (:background ,selection))))
       `(highlight-80+ ((,class (:background ,current-line))))
       ;; Python-specific overrides
       `(py-builtins-face ((,class (:foreground ,orange
                                    :weight normal))))
       ;; js2-mode
       `(js2-warning ((,class (:underline ,orange))))
       `(js2-error ((,class (:foreground unspecified
                             :underline ,red))))
       `(js2-external-variable ((,class (:foreground ,purple))))
       `(js2-function-param ((,class (:foreground ,blue))))
       `(js2-instance-member ((,class (:foreground ,blue))))
       `(js2-private-function-call ((,class (:foreground ,red))))
       ;; js3-mode
       `(js3-warning-face ((,class (:underline ,orange))))
       `(js3-error-face ((,class (:foreground unspecified
                                  :underline ,red))))
       `(js3-external-variable-face ((,class (:foreground ,purple))))
       `(js3-function-param-face ((,class (:foreground ,blue))))
       `(js3-jsdoc-tag-face ((,class (:foreground ,orange))))
       `(js3-jsdoc-type-face ((,class (:foreground ,aqua))))
       `(js3-jsdoc-value-face ((,class (:foreground ,yellow))))
       `(js3-jsdoc-html-tag-name-face ((,class (:foreground ,blue))))
       `(js3-jsdoc-html-tag-delimiter-face ((,class (:foreground ,green))))
       `(js3-instance-member-face ((,class (:foreground ,blue))))
       `(js3-private-function-call-face ((,class (:foreground ,red))))
       ;; coffee-mode
       `(coffee-mode-class-name ((,class (:foreground ,orange
                                          :weight bold))))
       `(coffee-mode-function-param ((,class (:foreground ,purple))))
       ;; nxml
       `(nxml-name-face
         ((,class (:foreground unspecified
                   :inherit font-lock-constant-face))))
       `(nxml-attribute-local-name-face
         ((,class
           (:foreground unspecified
            :inherit
            font-lock-variable-name-face))))
       `(nxml-ref-face ((,class (:foreground unspecified
                                 :inherit
                                 font-lock-preprocessor-face))))
       `(nxml-delimiter-face
         ((,class (:foreground unspecified
                   :inherit font-lock-keyword-face))))
       `(nxml-delimited-data-face ((,class (:foreground unspecified
                                            :inherit
                                            font-lock-string-face))))
       `(rng-error-face ((,class (:underline ,red))))
       ;; RHTML
       `(erb-delim-face ((,class (:background ,current-line))))
       `(erb-exec-face ((,class (:background ,current-line
                                 :weight bold))))
       `(erb-exec-delim-face ((,class (:background ,current-line))))
       `(erb-out-face ((,class (:background ,current-line
                                :weight bold))))
       `(erb-out-delim-face ((,class (:background ,current-line))))
       `(erb-comment-face ((,class (:background ,current-line
                                    :weight bold
                                    :slant italic))))
       `(erb-comment-delim-face ((,class (:background ,current-line))))
       ;; Message-mode
       `(message-header-other ((,class (:foreground unspecified
                                        :background unspecified
                                        :weight normal))))
       `(message-header-subject ((,class (:inherit message-header-other
                                          :weight bold
                                          :foreground ,yellow))))
       `(message-header-to ((,class (:inherit message-header-other
                                     :weight bold
                                     :foreground ,orange))))
       `(message-header-cc ((,class (:inherit message-header-to
                                     :foreground unspecified))))
       `(message-header-name ((,class (:foreground ,blue
                                       :background unspecified))))
       `(message-header-newsgroups ((,class (:foreground ,aqua
                                             :background unspecified
                                             :slant normal))))
       `(message-separator ((,class (:foreground ,purple))))
       ;; Jabber
       `(jabber-chat-prompt-local ((,class (:foreground ,yellow))))
       `(jabber-chat-prompt-foreign ((,class (:foreground ,orange))))
       `(jabber-chat-prompt-system ((,class (:foreground ,yellow
                                             :weight bold))))
       `(jabber-chat-text-local ((,class (:foreground ,yellow))))
       `(jabber-chat-text-foreign ((,class (:foreground ,orange))))
       `(jabber-chat-text-error ((,class (:foreground ,red))))
       `(jabber-roster-user-online ((,class (:foreground ,green))))
       `(jabber-roster-user-xa ((,class :foreground ,comment)))
       `(jabber-roster-user-dnd ((,class :foreground ,yellow)))
       `(jabber-roster-user-away ((,class (:foreground ,orange))))
       `(jabber-roster-user-chatty ((,class (:foreground ,purple))))
       `(jabber-roster-user-error ((,class (:foreground ,red))))
       `(jabber-roster-user-offline ((,class (:foreground ,comment))))
       `(jabber-rare-time-face ((,class (:foreground ,comment))))
       `(jabber-activity-face ((,class (:foreground ,purple))))
       `(jabber-activity-personal-face ((,class (:foreground ,aqua))))
       ;; Powerline
       `(powerline-active1 ((t (:foreground ,foreground
                                :background ,selection))))
       `(powerline-active2 ((t (:foreground ,foreground
                                :background ,current-line))))
       ;; Outline
       `(outline-1 ((,class (:inherit nil
                             :foreground "SkyBlue1"))))
       `(outline-2 ((,class (:inherit nil
                             :foreground ,yellow))))
       `(outline-3 ((,class (:inherit nil
                             :foreground ,purple))))
       `(outline-4 ((,class (:inherit nil
                             :foreground ,aqua))))
       `(outline-5 ((,class (:inherit nil
                             :foreground ,orange))))
       `(outline-6 ((,class (:inherit nil
                             :foreground "#00009a9acdcd"))))
       `(outline-7 ((,class (:inherit nil
                             :foreground "#8787cecefafa"))))
       `(outline-8 ((,class (:inherit nil
                             :foreground "turquoise2"))))
       `(outline-9 ((,class (:inherit nil
                             :foreground "LightSteelBlue1"))))
       ;; Ledger-mode
       `(ledger-font-comment-face ((,class (:inherit font-lock-comment-face))))
       `(ledger-font-occur-narrowed-face ((,class (:inherit
                                                   font-lock-comment-face
                                                   :invisible t))))
       `(ledger-font-occur-xact-face ((,class (:inherit highlight))))
       `(ledger-font-payee-cleared-face ((,class (:foreground ,green))))
       `(ledger-font-payee-uncleared-face ((,class (:foreground ,aqua))))
       `(ledger-font-posting-account-cleared-face ((,class (:foreground ,blue))))
       `(ledger-font-posting-account-face ((,class (:foreground ,purple))))
       `(ledger-font-posting-account-pending-face
         ((,class (:foreground ,yellow))))
       `(ledger-font-xact-highlight-face ((,class (:inherit highlight))))
       `(ledger-occur-narrowed-face ((,class (:inherit font-lock-comment-face
                                              :invisible t))))
       `(ledger-occur-xact-face ((,class (:inherit highlight))))
       ;; mu4e
       `(mu4e-header-highlight-face ((,class (:underline nil
                                              :inherit region))))
       `(mu4e-header-marks-face ((,class (:underline nil
                                          :foreground ,yellow))))
       `(mu4e-flagged-face ((,class (:foreground ,orange
                                     :inherit nil))))
       `(mu4e-replied-face ((,class (:foreground ,blue
                                     :inherit nil))))
       `(mu4e-unread-face ((,class (:foreground ,yellow
                                    :inherit nil))))
       `(mu4e-cited-1-face ((,class (:inherit outline-1
                                     :slant normal))))
       `(mu4e-cited-2-face ((,class (:inherit outline-2
                                     :slant normal))))
       `(mu4e-cited-3-face ((,class (:inherit outline-3
                                     :slant normal))))
       `(mu4e-cited-4-face ((,class (:inherit outline-4
                                     :slant normal))))
       `(mu4e-cited-5-face ((,class (:inherit outline-5
                                     :slant normal))))
       `(mu4e-cited-6-face ((,class (:inherit outline-6
                                     :slant normal))))
       `(mu4e-cited-7-face ((,class (:inherit outline-7
                                     :slant normal))))
       `(mu4e-ok-face ((,class (:foreground ,green))))
       `(mu4e-view-contact-face ((,class (:inherit nil
                                          :foreground ,yellow))))
       `(mu4e-view-link-face ((,class (:inherit link
                                       :foreground ,blue))))
       `(mu4e-view-url-number-face ((,class (:inherit nil
                                             :foreground ,aqua))))
       `(mu4e-view-attach-number-face ((,class (:inherit nil
                                                :foreground ,orange))))
       `(mu4e-highlight-face ((,class (:inherit highlight))))
       `(mu4e-title-face ((,class (:inherit nil
                                   :foreground ,green))))
       ;; Gnus
       `(gnus-cite-1 ((,class (:inherit outline-1
                               :foreground unspecified))))
       `(gnus-cite-2 ((,class (:inherit outline-2
                               :foreground unspecified))))
       `(gnus-cite-3 ((,class (:inherit outline-3
                               :foreground unspecified))))
       `(gnus-cite-4 ((,class (:inherit outline-4
                               :foreground unspecified))))
       `(gnus-cite-5 ((,class (:inherit outline-5
                               :foreground unspecified))))
       `(gnus-cite-6 ((,class (:inherit outline-6
                               :foreground unspecified))))
       `(gnus-cite-7 ((,class (:inherit outline-7
                               :foreground unspecified))))
       `(gnus-cite-8 ((,class (:inherit outline-8
                               :foreground unspecified))))
       ;; there are several more -cite- faces...
       `(gnus-header-content ((,class (:inherit message-header-other))))
       `(gnus-header-subject ((,class (:inherit message-header-subject))))
       `(gnus-header-from ((,class (:inherit message-header-other-face
                                    :weight bold
                                    :foreground ,orange))))
       `(gnus-header-name ((,class (:inherit message-header-name))))
       `(gnus-button ((,class (:inherit link
                               :foreground unspecified))))
       `(gnus-signature ((,class (:inherit font-lock-comment-face))))
       `(gnus-summary-normal-unread ((,class (:foreground ,blue
                                              :weight normal))))
       `(gnus-summary-normal-read ((,class (:foreground ,foreground
                                            :weight normal))))
       `(gnus-summary-normal-ancient ((,class (:foreground ,aqua
                                               :weight normal))))
       `(gnus-summary-normal-ticked ((,class (:foreground ,orange
                                              :weight normal))))
       `(gnus-summary-low-unread ((,class (:foreground ,comment
                                           :weight normal))))
       `(gnus-summary-low-read ((,class (:foreground ,comment
                                         :weight normal))))
       `(gnus-summary-low-ancient ((,class (:foreground ,comment
                                            :weight normal))))
       `(gnus-summary-high-unread ((,class (:foreground ,yellow
                                            :weight normal))))
       `(gnus-summary-high-read ((,class (:foreground ,green
                                          :weight normal))))
       `(gnus-summary-high-ancient ((,class (:foreground ,green
                                             :weight normal))))
       `(gnus-summary-high-ticked ((,class (:foreground ,orange
                                            :weight normal))))
       `(gnus-summary-cancelled ((,class (:foreground ,red
                                          :background unspecified
                                          :weight normal))))
       `(gnus-group-mail-low ((,class (:foreground ,comment))))
       `(gnus-group-mail-low-empty ((,class (:foreground ,comment))))
       `(gnus-group-mail-1 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-1))))
       `(gnus-group-mail-2 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-2))))
       `(gnus-group-mail-3 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-3))))
       `(gnus-group-mail-4 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-4))))
       `(gnus-group-mail-5 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-5))))
       `(gnus-group-mail-6 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-6))))
       `(gnus-group-mail-1-empty ((,class (:inherit gnus-group-mail-1
                                           :foreground ,comment))))
       `(gnus-group-mail-2-empty ((,class (:inherit gnus-group-mail-2
                                           :foreground ,comment))))
       `(gnus-group-mail-3-empty ((,class (:inherit gnus-group-mail-3
                                           :foreground ,comment))))
       `(gnus-group-mail-4-empty ((,class (:inherit gnus-group-mail-4
                                           :foreground ,comment))))
       `(gnus-group-mail-5-empty ((,class (:inherit gnus-group-mail-5
                                           :foreground ,comment))))
       `(gnus-group-mail-6-empty ((,class (:inherit gnus-group-mail-6
                                           :foreground ,comment))))
       `(gnus-group-news-1 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-5))))
       `(gnus-group-news-2 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-6))))
       `(gnus-group-news-3 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-7))))
       `(gnus-group-news-4 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-8))))
       `(gnus-group-news-5 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-1))))
       `(gnus-group-news-6 ((,class (:foreground unspecified
                                     :weight normal
                                     :inherit outline-2))))
       `(gnus-group-news-1-empty ((,class (:inherit gnus-group-news-1
                                           :foreground ,comment))))
       `(gnus-group-news-2-empty ((,class (:inherit gnus-group-news-2
                                           :foreground ,comment))))
       `(gnus-group-news-3-empty ((,class (:inherit gnus-group-news-3
                                           :foreground ,comment))))
       `(gnus-group-news-4-empty ((,class (:inherit gnus-group-news-4
                                           :foreground ,comment))))
       `(gnus-group-news-5-empty ((,class (:inherit gnus-group-news-5
                                           :foreground ,comment))))
       `(gnus-group-news-6-empty ((,class (:inherit gnus-group-news-6
                                           :foreground ,comment))))
       ;; emms
       `(emms-playlist-selected-face ((,class (:foreground ,orange))))
       `(emms-playlist-track-face ((,class (:foreground ,blue))))
       `(emms-browser-track-face ((,class (:foreground ,blue))))
       `(emms-browser-artist-face ((,class (:foreground ,red
                                            :height 1.3))))
       `(emms-browser-composer-face
         ((,class (:inherit emms-browser-artist-face))))
       `(emms-browser-performer-face ((,class
                                       (:inherit emms-browser-artist-face))))
       `(emms-browser-album-face ((,class (:foreground ,green
                                           :height 1.2))))
       ;; stripe-buffer
       `(stripe-highlight ((,class (:background ,current-line))))
       `(stripe-hl-line ((,class (:background ,selection
                                  :foreground ,foreground))))
       ;; erc
       `(erc-direct-msg-face ((,class (:foreground ,orange))))
       `(erc-error-face ((,class (:foreground ,red))))
       `(erc-header-face ((,class (:foreground ,foreground
                                   :background ,selection))))
       `(erc-input-face ((,class (:foreground ,green))))
       `(erc-keyword-face ((,class (:foreground ,yellow))))
       `(erc-current-nick-face ((,class (:foreground ,green))))
       `(erc-my-nick-face ((,class (:foreground ,green))))
       `(erc-nick-default-face ((,class (:weight normal
                                         :foreground ,purple))))
       `(erc-nick-msg-face ((,class (:weight normal
                                     :foreground ,yellow))))
       `(erc-notice-face ((,class (:foreground ,comment))))
       `(erc-pal-face ((,class (:foreground ,orange))))
       `(erc-prompt-face ((,class (:foreground ,blue))))
       `(erc-timestamp-face ((,class (:foreground ,aqua))))
       `(erc-keyword-face ((,class (:foreground ,green))))
       ;; twittering-mode
       `(twittering-username-face ((,class (:inherit erc-pal-face))))
       `(twittering-uri-face ((,class (:foreground ,blue
                                       :inherit link))))
       `(twittering-timeline-header-face ((,class (:foreground ,green
                                                   :weight bold))))
       `(twittering-timeline-footer-face
         ((,class
           (:inherit twittering-timeline-header-face))))
       `(custom-button ((,class (:box (:line-width (3 . 1)
                                       :style released-button
                                       :color "khaki1")
                                 :foreground "khaki1"))))
       `(custom-button-pressed ((,class (:box (:line-width (3 . 1)
                                               :style pressed-button
                                               :color ,orange)
                                         :foreground ,orange))))
       `(custom-button-mouse ((,class (:box (:line-width (3 . 1)
                                             :style pressed-button
                                             :color "khaki1")
                                       :foreground "khaki1"))))
       `(custom-button-unraised ((,class (:background "#0a0a0a0a0a0a"
                                          :foreground "white"))))
       `(custom-variable-tag ((,class (:foreground ,blue))))
       `(custom-group-tag ((,class (:foreground ,blue))))
       `(custom-state ((,class (:foreground ,green))))
       ;; ansi-term
       `(term ((,class (:foreground unspecified
                        :background unspecified
                        :inherit default))))
       `(term-color-black   ((,class (:foreground ,foreground
                                      :background ,foreground))))
       `(term-color-red     ((,class (:foreground ,red
                                      :background ,red))))
       `(term-color-green   ((,class (:foreground ,green
                                      :background ,green))))
       `(term-color-yellow  ((,class (:foreground ,yellow
                                      :background ,yellow))))
       `(term-color-blue    ((,class (:foreground ,blue
                                      :background ,blue))))
       `(term-color-magenta ((,class (:foreground ,purple
                                      :background ,purple))))
       `(term-color-cyan    ((,class (:foreground ,aqua
                                      :background ,aqua))))
       `(term-color-white   ((,class (:foreground ,background
                                      :background ,background))))
       `(aw-leading-char-face
         ((,class
           (:foreground "magenta"
            :box
            (:line-width 2
             :color
             "magenta"
             :style
             pressed-button)))))
       `(tab-bar ((,class (:background ,background
                           :foreground ,orange
                           :inherit variable-pitch))))
       `(tab-line ((,class (:foreground "#eaeaea"
                            :background ,background
                            :inherit tab-bar))))
       `(tab-bar-tab-inactive ((,class (:background "gray7"
                                        :foreground "dark gray"))))
       `(tab-bar-tab-group-inactive ((,class (:inherit mode-line-inactive))))
       `(tab-bar-tab-ungrouped ((,class (:inherit mode-line-inactive))))
       `(tab-line ((,class (:box
                            (:line-width 2
                             :color
                             "magenta"
                             :style
                             pressed-button)))))
       `(tab-line-highlight ((,class (:background "gray7"))))
       `(tab-line-tab-current ((,class (:background ,background
                                        :foreground ,orange))))
       `(tab-line-tab-inactive ((,class (:background "#181a23"
                                         :foreground "dark gray"))))
       `(tab-line-tab-inactive-alternate
         ((,class
           (:background ,background
            :foreground "dark gray"))))
       `(transient-key-exit ((,class (:inherit transient-key
                                      :foreground "SeaGreen2"
                                      :weight semi-bold))))
       `(transient-key-stay ((,class (:inherit font-lock-builtin-face
                                      :foreground "LightCoral"))))
       `(mouse-face ((,class
                      (:foreground ,orange))))
       `(completions-highlight ((,class
                                 (:background ,orange
                                  :foreground "black"))))
       `(completions-annotations ((,class
                                   (:foreground "LightCoral"))))
       `(completions-common-part ((,class
                                   (:foreground "#6363b8b8ffff"))))
       `(help-key-binding ((,class
                            (:foreground ,yellow))))
       `(popup-face
         ((,class
           (:background "gray2"
            :foreground "#fafafafad2d2"))))
       `(popup-summary-face
         ((,class
           (:background "black"
            :foreground "#eeeedddd8282"))))
       `(popup-scroll-bar-foreground-face
         ((,class
           (:background "#696969696969"))))
       `(popup-scroll-bar-background-face
         ((,class
           (:background "gold"))))
       `(popup-menu-mouse-face
         ((,class
           (:background "#696969696969"))))
       `(popup-menu-selection-face
         ((,class
           (:background "#fafafafad2d2"
            :foreground "black"))))
       `(popup-tip-face
         ((,class
           (:background "black"
            :foreground "#fafafafad2d2"))))
       `(Man-overstrike ((,class (:foreground ,orange))))
       `(Man-reverse ((,class (:inherit success))))
       `(Man-underline ((,class (:inherit (underline font-lock-builtin-face))))))
      (custom-theme-set-variables
       'afternoon
       `(fci-rule-color ,current-line)
       `(vc-annotate-color-map
         '((20  . ,red)
           (40  . ,orange)
           (60  . ,yellow)
           (80  . ,green)
           (100 . ,aqua)
           (120 . ,blue)
           (140 . ,purple)
           (160 . ,red)
           (180 . ,orange)
           (200 . ,yellow)
           (220 . ,green)
           (240 . ,aqua)
           (260 . ,blue)
           (280 . ,purple)
           (300 . ,red)
           (320 . ,orange)
           (340 . ,yellow)
           (360 . ,green)))
       `(vc-annotate-very-old-color nil)
       `(vc-annotate-background nil)
       `(ansi-color-names-vector (vector ,foreground ,red ,green ,yellow ,blue
                                  ,purple ,aqua ,background))
       '(ansi-color-faces-vector [default bold shadow italic underline bold
                                  bold-italic bold])))))


(defun afternoon-custom-theme-to-source ()
  "Copy `custom-set-faces' as source code."
  (interactive)
  (when (file-exists-p custom-file)
    (let ((items (with-temp-buffer (insert-file-contents custom-file)
                                   (let ((sexps)
                                         (sexp))
                                     (goto-char (point-min))
                                     (while
                                         (setq sexp
                                               (ignore-errors
                                                 (read
                                                  (current-buffer))))
                                       (pcase sexp
                                         (`(custom-set-faces . ,body)
                                          (push body
                                                sexps))))
                                     (car sexps))))
          (result)
          (str))
      (dolist (body items)
        (while (memq (car-safe body) '(quote function))
          (setq body (cadr body)))
        (when (eq (caaadr body) t)
          (let ((spec (cadr (caadr body))))
            (push `(,(car body)
                    ((`,class ,spec)))
                  result))))
      (setq str (replace-regexp-in-string "`,class[\s]" ",class "
                                          (mapconcat (lambda (i)
                                                       (concat
                                                        "`"
                                                        (prin1-to-string
                                                         i)))
                                                     (reverse result) "\n")))
      (kill-new str)
      (momentary-string-display (concat "\n" str "\n")
                                (point))
      str)))

;;;###autoload
(when (and (boundp 'custom-theme-load-path)
           load-file-name)
  ;; add theme folder to `custom-theme-load-path' when installing over MELPA
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(defun afternoon-theme-eval-and-load ()
  "Eval current buffer and load afternoon theme."
  (eval-buffer)
  (load-theme 'afternoon t nil))

(afternoon-create-theme afternoon-custom-colors)

(provide-theme 'afternoon)

;; Local Variables:
;; rainbow-mode: t
;; hl-sexp-mode: nil
;; prettier-elisp-mode: nil
;; after-save-hook: afternoon-theme-eval-and-load
;; End:

;;; afternoon-theme.el ends here
