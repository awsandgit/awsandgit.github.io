(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head
      (concat
       "<link rel=\"apple-touch-icon\" sizes=\"180x180\" href=\"assets/favicon/apple-touch-icon.png\">\n"
       "<link rel=\"icon\" type=\"image/png\" sizes=\"32x32\" href=\"assets/favicon/favicon-32x32.png\">\n"
       "<link rel=\"icon\" type=\"image/png\" sizes=\"16x16\" href=\"assets/favicon/favicon-16x16.png\">\n"
       "<link rel=\"manifest\" href=\"assets/favicon/site.webmanifest\">\n"
       ;; "<link rel=\"stylesheet\" href=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/css/htmlize.css\" />\n"
       ;; "<link rel=\"stylesheet\" href=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/css/readtheorg.css\" />\n"
       ;; "<link rel=\"stylesheet\" href=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/css/hideshow.css\" />\n"
       "<link rel=\"stylesheet\" href=\"assets/css/tokyo-night-dark.min.css\" />\n"
       "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\" />\n"
       "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/tokyo-night-dark.min.css\" />\n"
       "<link rel=\"stylesheet\" href=\"https://unpkg.com/highlightjs-copy/dist/highlightjs-copy.min.css\" />\n"
       "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />\n"
       ;;scripts
       "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js\"></script>\n"
       "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/yaml.min.js\"></script>\n"
       "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/groovy.min.js\"></script>\n"
       "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/json.min.js\"></script>\n"
       "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/bash.min.js\"></script>\n"
       "<script src=\"https://unpkg.com/highlightjs-copy/dist/highlightjs-copy.min.js\"></script>\n"
       ;; bootstrap
       "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\n"
       "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js\"></script>\n"
       "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js\"></script>\n"
       ;; bootstrap
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery-1.11.0.min.js\"></script>\n"
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery.localscroll-min.js\"></script>\n"
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery.scrollTo-1.4.3.1-min.js\"></script>\n"
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/jquery.zclip.min.js\"></script>\n"
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/readtheorg.js\"></script>\n"
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/readtheorg_theme/js/hideshow.js\"></script>\n"
       ;; "<script src=\"https://fniessen.github.io/org-html-themes/src/lib/js/jquery.stickytableheaders.min.js\"></script>\n"
       "<script src=\"assets/js/style.js\"></script>\n"
       "<link rel=\"stylesheet\" href=\"assets/css/style.css\" />\n"))

(setq org-html-preamble
      "<div class=\"navbar navbar-expand-xl bg-dark pt-1 pb-1 navbar-dark fixed-top\">
        <!-- navbar-brand -->
        <a href=\"/\" class=\"navbar-brand font-weight-bolder text-monospace text-light\">
          awsandgit.github.io
          <!-- <img src=\"mylogowhitesmall.png\" style=\"width: 60px;\"> -->
        </a>

        <!-- Burger icon as toggler for nav-items -->
        <button type=\"button\" class=\"navbar-toggler\" data-toggle=\"collapse\" data-target=\"#navtarget\">
          <span class=\"navbar-toggler-icon\"></span>
        </button>

        <!-- Collapsed navbar data -->
        <div class=\"collapse navbar-collapse\" id=\"navtarget\">
          <ul class=\"navbar-nav font-weight-bold\">
            <li class=\"nav-item\">
              <a href=\"https://rohitknows.github.io\" class=\"nav-link\" data-toggle=\"collapse\">Portfolio</a>
            </li>
            <li class=\"nav-item\">
              <a href=\"/\" class=\"nav-link\">Notes</a>
            </li>
            <li class=\"nav-item\">
              <a href=\"/about.html\" class=\"nav-link\">About</a>
            </li>
            <li class=\"nav-item\">
              <a href=\"https://rohitknows.github.io\" class=\"nav-link\">Contact</a>
            </li>
          </ul>
        </div>
      </div><br>")

(defun org2html-trim-string (string)
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun org2html--char-to-string (ch)
  (let ((chspc 32)
        (chsq 39)
        (ch0 48)
        (ch9 57)
        (cha 97)
        (chz 122)
        (chA 65)
        (chZ 90)
        (chdot 46)
        (chminus 45)
        (chunderscore 95)
        rlt)
    (cond
     ((or (and (<= ch0 ch) (<= ch ch9))
          (and (<= cha ch) (<= ch chz))
          (and (<= chA ch) (<= ch chZ))
          (= chunderscore ch)
          (= chminus ch)
          )
      (setq rlt (char-to-string ch)))
     ((or (= chspc ch) (= chsq ch) (= chdot ch))
      (setq rlt "-")))
    rlt
    ))

(defun org2html-get-slug (str)
  (let (slug )
    (setq slug (mapconcat 'org2html--char-to-string str ""))
    ;; clean slug a little bit
    (setq slug (replace-regexp-in-string "\\-\\-+" "-" slug))
    (setq slug (replace-regexp-in-string "^\\-+" "" slug))
    (setq slug (replace-regexp-in-string "\\-+$" "" slug))
    (setq slug (org2html-trim-string slug))
    (setq slug (downcase slug))
    slug))

(defun org2html-replace-pre (html)
  "Replace pre blocks with sourcecode shortcode blocks.
      shamelessly copied from org2blog/wp-replace-pre()"
  (save-excursion
    (let (pos code lang info params header code-start code-end html-attrs pre-class)
      (with-temp-buffer
        (insert html)
        (goto-char (point-min))
        (save-match-data
          (while (re-search-forward "<pre\\(.*?\\)>" nil t 1)

            ;; When the codeblock is a src_block
            (unless
                (save-match-data
                  (setq pre-class (match-string-no-properties 1))
                  (string-match "example" pre-class))
              ;; Replace the <pre...> text
              (setq lang (replace-regexp-in-string ".*src-\\([a-zA-Z0-9]+\\).*" "\\1" pre-class)  )

              (replace-match "")
              (setq code-start (point))

              ;; Go to end of code and remove </pre>
              (re-search-forward "</pre.*?>" nil t 1)
              (replace-match "")
              (setq code-end (point))
              (setq code (buffer-substring-no-properties code-start code-end))

              ;; Delete the code
              (delete-region code-start code-end)
              ;; Stripping out all the code highlighting done by htmlize
              (setq code (replace-regexp-in-string "<.*?>" "" code))

              ;; default is highlight.js, it's the best!
              (insert (concat "\n<pre><code class=\"lang-"
                              lang
                              "\">"
                              code
                              "</code></pre>\n"))

              )))

        ;; Get the new html!
        (setq html (buffer-substring-no-properties (point-min) (point-max))))
      ))
  html)

(defun org2html-wrap-blocks-in-code (src backend info)
  (if (org-export-derived-backend-p backend 'html)
      (org2html-replace-pre src)))

(eval-after-load 'ox
  '(progn
     (add-to-list 'org-export-filter-src-block-functions
                  'org2html-wrap-blocks-in-code)
     ))

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil
             :with-creator nil
             :with-toc t
             :section-numbers nil
             :time-stamp-file nil)
       (list "org-site:static"
             :recursive t
             :base-directory "./content/assets"
             :publishing-directory "./public/assets"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|svg\\|ico\\|ttf\\|woff\\|woff2"
             :publishing-function 'org-publish-attachment)))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
