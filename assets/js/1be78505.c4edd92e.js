"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[514,35,495],{27003:function(e,t,n){n.r(t),n.d(t,{default:function(){return S}});var a=n(67294),r=n(3905),o=n(46291),c=n(54814),l=n(10284),i=n(61914),s=n(24608),d=n(34096),u=n(86010),m=n(95999),h="backToTopButton_35hR",p="backToTopButtonShow_18ls",b=n(32822);function f(){var e=(0,a.useRef)(null);return{smoothScrollTop:function(){var t;e.current=(t=null,function e(){var n=document.documentElement.scrollTop;n>0&&(t=requestAnimationFrame(e),window.scrollTo(0,Math.floor(.85*n)))}(),function(){return t&&cancelAnimationFrame(t)})},cancelScrollToTop:function(){return null==e.current?void 0:e.current()}}}var v=function(){var e,t=(0,a.useState)(!1),n=t[0],r=t[1],o=(0,a.useRef)(!1),c=f(),l=c.smoothScrollTop,i=c.cancelScrollToTop;return(0,b.RF)((function(e,t){var n=e.scrollY,a=null==t?void 0:t.scrollY;if(a)if(o.current)o.current=!1;else{var c=n<a;if(c||i(),n<300)r(!1);else if(c){var l=document.documentElement.scrollHeight;n+window.innerHeight<l&&r(!0)}else r(!1)}})),(0,b.SL)((function(e){e.location.hash&&(o.current=!0,r(!1))})),a.createElement("button",{"aria-label":(0,m.I)({id:"theme.BackToTopButton.buttonAriaLabel",message:"Scroll back to top",description:"The ARIA label for the back to top button"}),className:(0,u.Z)("clean-btn",b.kM.common.backToTopButton,h,(e={},e[p]=n,e)),type:"button",onClick:function(){return l()}})},E=n(76775),k={docPage:"docPage_31aa",docMainContainer:"docMainContainer_3ufF",docSidebarContainer:"docSidebarContainer_3Kbt",docMainContainerEnhanced:"docMainContainerEnhanced_3NYZ",docSidebarContainerHidden:"docSidebarContainerHidden_3pA8",collapsedDocSidebar:"collapsedDocSidebar_2JMH",expandSidebarButtonIcon:"expandSidebarButtonIcon_1naQ",docItemWrapperEnhanced:"docItemWrapperEnhanced_2vyJ"},g=n(12859);function _(e){var t,n,o,s=e.currentDocRoute,h=e.versionMetadata,p=e.children,f=h.pluginId,E=h.version,g=s.sidebar,_=g?h.docsSidebars[g]:void 0,S=(0,a.useState)(!1),C=S[0],Z=S[1],N=(0,a.useState)(!1),I=N[0],T=N[1],M=(0,a.useCallback)((function(){I&&T(!1),Z((function(e){return!e}))}),[I]);return a.createElement(c.Z,{wrapperClassName:b.kM.wrapper.docsPages,pageClassName:b.kM.page.docsDocPage,searchMetadatas:{version:E,tag:(0,b.os)(f,E)}},a.createElement("div",{className:k.docPage},a.createElement(v,null),_&&a.createElement("aside",{className:(0,u.Z)(k.docSidebarContainer,(t={},t[k.docSidebarContainerHidden]=C,t)),onTransitionEnd:function(e){e.currentTarget.classList.contains(k.docSidebarContainer)&&C&&T(!0)}},a.createElement(l.Z,{key:g,sidebar:_,path:s.path,onCollapse:M,isHidden:I}),I&&a.createElement("div",{className:k.collapsedDocSidebar,title:(0,m.I)({id:"theme.docs.sidebar.expandButtonTitle",message:"Expand sidebar",description:"The ARIA label and title attribute for expand button of doc sidebar"}),"aria-label":(0,m.I)({id:"theme.docs.sidebar.expandButtonAriaLabel",message:"Expand sidebar",description:"The ARIA label and title attribute for expand button of doc sidebar"}),tabIndex:0,role:"button",onKeyDown:M,onClick:M},a.createElement(d.Z,{className:k.expandSidebarButtonIcon}))),a.createElement("main",{className:(0,u.Z)(k.docMainContainer,(n={},n[k.docMainContainerEnhanced]=C||!_,n))},a.createElement("div",{className:(0,u.Z)("container padding-top--md padding-bottom--lg",k.docItemWrapper,(o={},o[k.docItemWrapperEnhanced]=C,o))},a.createElement(r.Zo,{components:i.Z},p)))))}var S=function(e){var t=e.route.routes,n=e.versionMetadata,r=e.location,c=t.find((function(e){return(0,E.LX)(r.pathname,e)}));return c?a.createElement(a.Fragment,null,a.createElement(g.Z,null,a.createElement("html",{className:n.className})),a.createElement(_,{currentDocRoute:c,versionMetadata:n},(0,o.Z)(t,{versionMetadata:n}))):a.createElement(s.default,null)}},10284:function(e,t,n){n.d(t,{Z:function(){return H}});var a=n(67294),r=n(86010),o=n(32822),c=n(93783),l=n(55537),i=n(34096),s=n(95999),d=n(87462),u=n(63366),m=n(39960),h=n(13919),p=n(90541),b="menuLinkText_1J2g",f=["items"],v=["item"],E=["item","onItemClick","activePath","level"],k=["item","onItemClick","activePath","level"],g=function e(t,n){return"link"===t.type?(0,o.Mg)(t.href,n):"category"===t.type&&t.items.some((function(t){return e(t,n)}))},_=(0,a.memo)((function(e){var t=e.items,n=(0,u.Z)(e,f);return a.createElement(a.Fragment,null,t.map((function(e,t){return a.createElement(S,(0,d.Z)({key:t,item:e},n))})))}));function S(e){var t=e.item,n=(0,u.Z)(e,v);return"category"===t.type?0===t.items.length?null:a.createElement(C,(0,d.Z)({item:t},n)):a.createElement(Z,(0,d.Z)({item:t},n))}function C(e){var t,n=e.item,c=e.onItemClick,l=e.activePath,i=e.level,s=(0,u.Z)(e,E),m=n.items,h=n.label,p=n.collapsible,f=n.className,v=g(n,l),k=(0,o.uR)({initialState:function(){return!!p&&(!v&&n.collapsed)}}),S=k.collapsed,C=k.setCollapsed,Z=k.toggleCollapsed;return function(e){var t=e.isActive,n=e.collapsed,r=e.setCollapsed,c=(0,o.D9)(t);(0,a.useEffect)((function(){t&&!c&&n&&r(!1)}),[t,c,n,r])}({isActive:v,collapsed:S,setCollapsed:C}),a.createElement("li",{className:(0,r.Z)(o.kM.docs.docSidebarItemCategory,o.kM.docs.docSidebarItemCategoryLevel(i),"menu__list-item",{"menu__list-item--collapsed":S},f)},a.createElement("a",(0,d.Z)({className:(0,r.Z)("menu__link",(t={"menu__link--sublist":p,"menu__link--active":p&&v},t[b]=!p,t)),onClick:p?function(e){e.preventDefault(),Z()}:void 0,href:p?"#":void 0},s),h),a.createElement(o.zF,{lazy:!0,as:"ul",className:"menu__list",collapsed:S},a.createElement(_,{items:m,tabIndex:S?-1:0,onItemClick:c,activePath:l,level:i+1})))}function Z(e){var t=e.item,n=e.onItemClick,c=e.activePath,l=e.level,i=(0,u.Z)(e,k),s=t.href,b=t.label,f=t.className,v=g(t,c);return a.createElement("li",{className:(0,r.Z)(o.kM.docs.docSidebarItemLink,o.kM.docs.docSidebarItemLinkLevel(l),"menu__list-item",f),key:b},a.createElement(m.Z,(0,d.Z)({className:(0,r.Z)("menu__link",{"menu__link--active":v}),"aria-current":v?"page":void 0,to:s},(0,h.Z)(s)&&{onClick:n},i),(0,h.Z)(s)?b:a.createElement("span",null,b,a.createElement(p.Z,null))))}var N="sidebar_15mo",I="sidebarWithHideableNavbar_267A",T="sidebarHidden_2kNb",M="sidebarLogo_3h0W",y="menu_Bmed",x="menuWithAnnouncementBar_2WvA",B="collapseSidebarButton_1CGd",w="collapseSidebarButtonIcon_3E-R";function P(e){var t=e.onClick;return a.createElement("button",{type:"button",title:(0,s.I)({id:"theme.docs.sidebar.collapseButtonTitle",message:"Collapse sidebar",description:"The title attribute for collapse button of doc sidebar"}),"aria-label":(0,s.I)({id:"theme.docs.sidebar.collapseButtonAriaLabel",message:"Collapse sidebar",description:"The title attribute for collapse button of doc sidebar"}),className:(0,r.Z)("button button--secondary button--outline",B),onClick:t},a.createElement(i.Z,{className:w}))}function A(e){var t,n,c=e.path,i=e.sidebar,s=e.onCollapse,d=e.isHidden,u=function(){var e=(0,o.nT)().isActive,t=(0,a.useState)(e),n=t[0],r=t[1];return(0,o.RF)((function(t){var n=t.scrollY;e&&r(0===n)}),[e]),e&&n}(),m=(0,o.LU)(),h=m.navbar.hideOnScroll,p=m.hideableSidebar;return a.createElement("div",{className:(0,r.Z)(N,(t={},t[I]=h,t[T]=d,t))},h&&a.createElement(l.Z,{tabIndex:-1,className:M}),a.createElement("nav",{className:(0,r.Z)("menu thin-scrollbar",y,(n={},n[x]=u,n))},a.createElement("ul",{className:(0,r.Z)(o.kM.docs.docSidebarMenu,"menu__list")},a.createElement(_,{items:i,activePath:c,level:1}))),p&&a.createElement(P,{onClick:s}))}var L=function(e){var t=e.toggleSidebar,n=e.sidebar,c=e.path;return a.createElement("ul",{className:(0,r.Z)(o.kM.docs.docSidebarMenu,"menu__list")},a.createElement(_,{items:n,activePath:c,onItemClick:function(){return t()},level:1}))};function F(e){return a.createElement(o.Cv,{component:L,props:e})}var R=a.memo(A),D=a.memo(F);function H(e){var t=(0,c.Z)(),n="desktop"===t||"ssr"===t,r="mobile"===t;return a.createElement(a.Fragment,null,n&&a.createElement(R,e),r&&a.createElement(D,e))}},34096:function(e,t,n){var a=n(87462),r=n(67294);t.Z=function(e){return r.createElement("svg",(0,a.Z)({width:"20",height:"20","aria-hidden":"true"},e),r.createElement("g",{fill:"#7a7a7a"},r.createElement("path",{d:"M9.992 10.023c0 .2-.062.399-.172.547l-4.996 7.492a.982.982 0 01-.828.454H1c-.55 0-1-.453-1-1 0-.2.059-.403.168-.551l4.629-6.942L.168 3.078A.939.939 0 010 2.528c0-.548.45-.997 1-.997h2.996c.352 0 .649.18.828.45L9.82 9.472c.11.148.172.347.172.55zm0 0"}),r.createElement("path",{d:"M19.98 10.023c0 .2-.058.399-.168.547l-4.996 7.492a.987.987 0 01-.828.454h-3c-.547 0-.996-.453-.996-1 0-.2.059-.403.168-.551l4.625-6.942-4.625-6.945a.939.939 0 01-.168-.55 1 1 0 01.996-.997h3c.348 0 .649.18.828.45l4.996 7.492c.11.148.168.347.168.55zm0 0"})))}},24608:function(e,t,n){n.r(t);var a=n(67294),r=n(54814),o=n(95999);t.default=function(){return a.createElement(r.Z,{title:(0,o.I)({id:"theme.NotFound.title",message:"Page Not Found"})},a.createElement("main",{className:"container margin-vert--xl"},a.createElement("div",{className:"row"},a.createElement("div",{className:"col col--6 col--offset-3"},a.createElement("h1",{className:"hero__title"},a.createElement(o.Z,{id:"theme.NotFound.title",description:"The title of the 404 page"},"Page Not Found")),a.createElement("p",null,a.createElement(o.Z,{id:"theme.NotFound.p1",description:"The first paragraph of the 404 page"},"We could not find what you were looking for.")),a.createElement("p",null,a.createElement(o.Z,{id:"theme.NotFound.p2",description:"The 2nd paragraph of the 404 page"},"Please contact the owner of the site that linked you to the original URL and let them know their link is broken."))))))}},6979:function(e,t,n){var a=n(76775),r=n(52263),o=n(28084),c=n(94184),l=n.n(c),i=n(67294);t.Z=function(e){var t=(0,i.useRef)(!1),c=(0,i.useRef)(null),s=(0,a.k6)(),d=(0,r.Z)().siteConfig,u=(void 0===d?{}:d).baseUrl;(0,i.useEffect)((function(){var e=function(e){"s"!==e.key&&"/"!==e.key||c.current&&e.srcElement===document.body&&(e.preventDefault(),c.current.focus())};return document.addEventListener("keydown",e),function(){document.removeEventListener("keydown",e)}}),[]);var m=(0,o.usePluginData)("docusaurus-lunr-search"),h=function(){t.current||(Promise.all([fetch(""+u+m.fileNames.searchDoc).then((function(e){return e.json()})),fetch(""+u+m.fileNames.lunrIndex).then((function(e){return e.json()})),Promise.all([n.e(878),n.e(245)]).then(n.bind(n,24130)),Promise.all([n.e(532),n.e(343)]).then(n.bind(n,53343))]).then((function(e){var t=e[0],n=e[1],a=e[2].default;0!==t.length&&function(e,t,n){new n({searchDocs:e,searchIndex:t,inputSelector:"#search_input_react",handleSelected:function(e,t,n){var a=u+n.url;document.createElement("a").href=a,s.push(a)}})}(t,n,a)})),t.current=!0)},p=(0,i.useCallback)((function(t){c.current.contains(t.target)||c.current.focus(),e.handleSearchBarToggle&&e.handleSearchBarToggle(!e.isSearchBarExpanded)}),[e.isSearchBarExpanded]);return i.createElement("div",{className:"navbar__search",key:"search-box"},i.createElement("span",{"aria-label":"expand searchbar",role:"button",className:l()("search-icon",{"search-icon-hidden":e.isSearchBarExpanded}),onClick:p,onKeyDown:p,tabIndex:0}),i.createElement("input",{id:"search_input_react",type:"search",placeholder:"Press S to Search...","aria-label":"Search",className:l()("navbar__search-input",{"search-bar-expanded":e.isSearchBarExpanded},{"search-bar":!e.isSearchBarExpanded}),onClick:h,onMouseOver:h,onFocus:p,onBlur:p,ref:c}))}}}]);