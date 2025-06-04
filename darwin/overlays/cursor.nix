# Overlay to patch the extensions target of Cursor to use the VSCode Marketplace
# https://gist.github.com/joeblackwaslike/752b26ce92e3699084e1ecfc790f74b2
let
  extensionsGalleryJson = ''
    {
      "galleryId": "cursor",
      "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
      "itemUrl": "https://marketplace.visualstudio.com/items",
      "resourceUrlTemplate": "https://{publisher}.vscode-unpkg.net/{publisher}/{name}/{version}/{path}",
      "controlUrl": "",
      "recommendationsUrl": "",
      "nlsBaseUrl": "",
      "publisherUrl": ""
    }
  '';
in
final: prev: {
  code-cursor = prev.code-cursor.overrideAttrs (oldAttrs: {
    buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ final.jq ];
    postInstall = ''
      ${oldAttrs.postInstall or ""}
      product_json="$out/Applications/Cursor.app/Contents/Resources/app/product.json"
      echo "Patching $product_json"
      if [ -f "$product_json" ]; then
       tmp_json=$(mktemp)
      # Change the extensionsGallery and remove .extensionMaxVersions
       jq --argjson extGallery '${extensionsGalleryJson}' '.extensionsGallery = $extGallery | del(.extensionMaxVersions)' "$product_json" > "$tmp_json"
       mv "$tmp_json" "$product_json"
      fi
    '';
  });
}
