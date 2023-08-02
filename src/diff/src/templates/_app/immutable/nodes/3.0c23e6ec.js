import{s as j,n as ee,e as ae,o as G,r as be}from"../chunks/scheduler.e108d1fd.js";import{S as B,i as U,g as b,s as y,m as A,H as re,h as w,j as $,c as C,x as P,n as q,f as g,C as ie,k as v,a as I,y as m,A as M,o as R,r as z,u as J,v as O,d as W,t as F,w as K,e as oe,B as te,z as ue}from"../chunks/index.3aeff6f3.js";import{e as H}from"../chunks/each.e59479a4.js";import{w as ge}from"../chunks/index.0378bb41.js";let Z=ge(""),x=ge("");function we(r){let e,t,l,a,i,n,c='<input type="checkbox" value="10.9.64.28" id="old" name="test_srv_list"/> 10.9.64.28',_,d,f='<input type="checkbox" value="10.162.138.83" id="new" name="test_srv_list"/> 10.162.138.83',s,o,h=`<input type="checkbox" value="10.8.3.125" id="local" name="test_srv_list" checked=""/> 10.8.3.125(test
				only)`,u,p,E,k,L,Q,T,N,X,le;return{c(){e=b("div"),t=b("div"),l=b("div"),a=b("input"),i=y(),n=b("label"),n.innerHTML=c,_=A(`
			|
			`),d=b("label"),d.innerHTML=f,s=y(),o=b("label"),o.innerHTML=h,u=y(),p=A(r[0]),E=y(),k=b("div"),L=new re(!1),Q=y(),T=b("div"),N=new re(!1),this.h()},l(V){e=w(V,"DIV",{class:!0});var D=$(e);t=w(D,"DIV",{class:!0});var Y=$(t);l=w(Y,"DIV",{class:!0});var S=$(l);a=w(S,"INPUT",{type:!0,class:!0}),i=C(S),n=w(S,"LABEL",{for:!0,"data-svelte-h":!0}),P(n)!=="svelte-1kkitpn"&&(n.innerHTML=c),_=q(S,`
			|
			`),d=w(S,"LABEL",{for:!0,"data-svelte-h":!0}),P(d)!=="svelte-1r6uq03"&&(d.innerHTML=f),s=C(S),o=w(S,"LABEL",{for:!0,"data-svelte-h":!0}),P(o)!=="svelte-1ce06w5"&&(o.innerHTML=h),S.forEach(g),u=C(Y),p=q(Y,r[0]),Y.forEach(g),E=C(D),k=w(D,"DIV",{class:!0});var se=$(k);L=ie(se,!1),se.forEach(g),Q=C(D),T=w(D,"DIV",{class:!0});var ne=$(T);N=ie(ne,!1),ne.forEach(g),D.forEach(g),this.h()},h(){v(a,"type","button"),a.value="SEND",v(a,"class","border pl-2 pr-2 mr-5 bg-blue-600 text-white rounded-md"),v(n,"for","old"),v(d,"for","new"),v(o,"for","local"),v(l,"class","w-full border-2 border-b-black"),v(t,"class","border w-full h-[73vh] p-1"),L.a=null,v(k,"class","border w-full h-[73vh] p-1"),N.a=null,v(T,"class","border w-full h-[73vh] p-1"),v(e,"class","flex flex-col justify-evenly border w-full h-[73vh] p-1")},m(V,D){I(V,e,D),m(e,t),m(t,l),m(l,a),m(l,i),m(l,n),m(l,_),m(l,d),m(l,s),m(l,o),m(t,u),m(t,p),m(e,E),m(e,k),L.m(r[1],k),m(e,Q),m(e,T),N.m(r[2],T),X||(le=M(a,"click",r[3]),X=!0)},p(V,[D]){D&1&&R(p,V[0]),D&2&&L.p(V[1]),D&4&&N.p(V[2])},i:ee,o:ee,d(V){V&&g(e),X=!1,le()}}}function ke(r,e,t){let l,a;ae(r,Z,s=>t(1,l=s)),ae(r,x,s=>t(2,a=s));let{msg:i}=e,n=[];const c=async()=>{if(Z.set(""),x.set(""),n=_(),i.length<=1){alert("Api message can not be send with nothing, Select the api to be tested and enter the correct test data.");return}if(n.length==0){alert("The IP address of the server to be tested cannot be empty. Select at least one of the server IP addresses to send test information.");return}d(n,i)},_=()=>{let s=[],o=document.getElementsByName("test_srv_list");for(let h=0;h<o.length;h++){let u=o[h];u.checked&&s.push(u.value)}return console.log(s),s},d=(s,o)=>{let h=new WebSocket("ws://10.8.3.125:30000");h.onopen=function(u){console.log("[open] Connection established"),console.log("Sending to server");for(const p of s)console.log(`Sending: ${p}>${o}`),h.send(`${p}>${o}`)},h.onmessage=function(u){console.log(`[message] Data received from server: ${u.data}`),f(u.data)},h.onclose=function(u){u.wasClean?console.log(`[close] Connection closed cleanly, code=${u.code} reason=${u.reason}`):console.log("[close] Connection died")},h.onerror=function(u){console.log(`[error]${JSON.stringify(u,null,4)}`)}},f=s=>{s.includes("10.162.138.83")?x.update(o=>s):Z.update(o=>s)};return G(()=>{console.log("msg:",i,i.length)}),r.$$set=s=>{"msg"in s&&t(0,i=s.msg)},[i,l,a,c]}class $e extends B{constructor(e){super(),U(this,e,ke,we,j,{msg:0})}}function ce(r,e,t){const l=r.slice();return l[4]=e[t],l[5]=e,l[6]=t,l}function fe(r){let e,t=(r[0].api_content===""?"":r[0].api_content)+"",l,a;return{c(){e=b("div"),l=A(t),this.h()},l(i){e=w(i,"DIV",{class:!0});var n=$(e);l=q(n,t),n.forEach(g),this.h()},h(){v(e,"class",a=r[0].api_content===""?"":"w-full bg-blue-500 p-0.5 text-sm text-red-100 rounded-md overflow-x-scroll")},m(i,n){I(i,e,n),m(e,l)},p(i,n){n&1&&t!==(t=(i[0].api_content===""?"":i[0].api_content)+"")&&R(l,t),n&1&&a!==(a=i[0].api_content===""?"":"w-full bg-blue-500 p-0.5 text-sm text-red-100 rounded-md overflow-x-scroll")&&v(e,"class",a)},d(i){i&&g(e)}}}function de(r){let e,t=H(r[0].api_param),l=[];for(let a=0;a<t.length;a+=1)l[a]=he(ce(r,t,a));return{c(){for(let a=0;a<l.length;a+=1)l[a].c();e=oe()},l(a){for(let i=0;i<l.length;i+=1)l[i].l(a);e=oe()},m(a,i){for(let n=0;n<l.length;n+=1)l[n]&&l[n].m(a,i);I(a,e,i)},p(a,i){if(i&1){t=H(a[0].api_param);let n;for(n=0;n<t.length;n+=1){const c=ce(a,t,n);l[n]?l[n].p(c,i):(l[n]=he(c),l[n].c(),l[n].m(e.parentNode,e))}for(;n<l.length;n+=1)l[n].d(1);l.length=t.length}},d(a){a&&g(e),te(l,a)}}}function he(r){let e,t,l=r[4].key+"",a,i,n,c,_,d,f,s,o,h;function u(){r[2].call(n,r[5],r[6])}function p(){return r[3](r[4],r[5],r[6])}return{c(){e=b("div"),t=b("label"),a=A(l),i=A("="),n=b("input"),s=y(),this.h()},l(E){e=w(E,"DIV",{class:!0});var k=$(e);t=w(k,"LABEL",{for:!0,class:!0});var L=$(t);a=q(L,l),i=q(L,"="),n=w(L,"INPUT",{type:!0,name:!0,id:!0,class:!0}),L.forEach(g),s=C(k),k.forEach(g),this.h()},h(){v(n,"type","text"),v(n,"name",c=r[4].key),v(n,"id",_=r[4].key),n.required=d=r[4].is_required,v(n,"class","w-[24vw] border float-right text-left text-slate-600 bg-slate-300"),v(t,"for",f=r[4].key),v(t,"class","w-[10vw]"),v(e,"class","border")},m(E,k){I(E,e,k),m(e,t),m(t,a),m(t,i),m(t,n),ue(n,r[4].value),m(e,s),o||(h=[M(n,"input",u),M(n,"change",p)],o=!0)},p(E,k){r=E,k&1&&l!==(l=r[4].key+"")&&R(a,l),k&1&&c!==(c=r[4].key)&&v(n,"name",c),k&1&&_!==(_=r[4].key)&&v(n,"id",_),k&1&&d!==(d=r[4].is_required)&&(n.required=d),k&1&&n.value!==r[4].value&&ue(n,r[4].value),k&1&&f!==(f=r[4].key)&&v(t,"for",f)},d(E){E&&g(e),o=!1,be(h)}}}function Ee(r){let e,t,l,a,i,n,c,_,d=r[0]!=null&&fe(r),f=r[0]!=null&&de(r);return c=new $e({props:{msg:r[1]}}),{c(){e=b("div"),d&&d.c(),t=y(),l=b("div"),a=b("div"),i=b("div"),f&&f.c(),n=y(),z(c.$$.fragment),this.h()},l(s){e=w(s,"DIV",{class:!0});var o=$(e);d&&d.l(o),o.forEach(g),t=C(s),l=w(s,"DIV",{class:!0});var h=$(l);a=w(h,"DIV",{class:!0});var u=$(a);i=w(u,"DIV",{class:!0});var p=$(i);f&&f.l(p),p.forEach(g),n=C(u),J(c.$$.fragment,u),u.forEach(g),h.forEach(g),this.h()},h(){v(e,"class","border-2 bg-white h-[7vh] w-full p-1 flex items-center"),v(i,"class","border w-[55vw] h-[73vh] p-1"),v(a,"class","flex flex-row justify-evenly"),v(l,"class","bg-white h-[73vh] p-1")},m(s,o){I(s,e,o),d&&d.m(e,null),I(s,t,o),I(s,l,o),m(l,a),m(a,i),f&&f.m(i,null),m(a,n),O(c,a,null),_=!0},p(s,[o]){s[0]!=null?d?d.p(s,o):(d=fe(s),d.c(),d.m(e,null)):d&&(d.d(1),d=null),s[0]!=null?f?f.p(s,o):(f=de(s),f.c(),f.m(i,null)):f&&(f.d(1),f=null);const h={};o&2&&(h.msg=s[1]),c.$set(h)},i(s){_||(W(c.$$.fragment,s),_=!0)},o(s){F(c.$$.fragment,s),_=!1},d(s){s&&(g(e),g(t),g(l)),d&&d.d(),f&&f.d(),K(c)}}}function Ie(r,e,t){let{api:l}=e,a="";function i(c,_){c[_].value=this.value,t(0,l)}const n=(c,_,d)=>t(0,_[d].value=c.value.toUpperCase(),l);return r.$$set=c=>{"api"in c&&t(0,l=c.api)},r.$$.update=()=>{if(r.$$.dirty&1){let c="";l!=null&&l.api_param.forEach(_=>{c+=`${_.key}=${_.value.includes(" ")&&_.key!="HDR"?`"${_.value.toUpperCase()}" `:`${_.value.toUpperCase()} `} `}),t(1,a=`${l==null?void 0:l.api_name} ${c}`)}},[l,a,i,n]}class ye extends B{constructor(e){super(),U(this,e,Ie,Ee,j,{api:0})}}function _e(r,e,t){const l=r.slice();return l[1]=e[t],l}function pe(r){let e,t,l,a,i;return{c(){e=b("input"),this.h()},l(n){e=w(n,"INPUT",{type:!0,class:!0}),this.h()},h(){v(e,"type","button"),e.value=t=r[1].api_name,v(e,"class",l="border "+(r[1].is_inuse=="Y"?"bg-green-400":"bg-red-400 ")+" p-1 m-1 text-sm text-yellow-50 hover:bg-blue-500 active:bg-blue-500 focus:bg-blue-500 rounded-md")},m(n,c){I(n,e,c),a||(i=M(e,"click",r[2]),a=!0)},p(n,c){c&1&&t!==(t=n[1].api_name)&&(e.value=t),c&1&&l!==(l="border "+(n[1].is_inuse=="Y"?"bg-green-400":"bg-red-400 ")+" p-1 m-1 text-sm text-yellow-50 hover:bg-blue-500 active:bg-blue-500 focus:bg-blue-500 rounded-md")&&v(e,"class",l)},d(n){n&&g(e),a=!1,i()}}}function Ce(r){let e,t,l="API LIST:",a,i,n,c,_,d=H(r[0]),f=[];for(let s=0;s<d.length;s+=1)f[s]=pe(_e(r,d,s));return c=new ye({props:{api:r[1]}}),{c(){e=b("div"),t=b("span"),t.textContent=l,a=y(),i=b("div");for(let s=0;s<f.length;s+=1)f[s].c();n=y(),z(c.$$.fragment),this.h()},l(s){e=w(s,"DIV",{class:!0});var o=$(e);t=w(o,"SPAN",{class:!0,"data-svelte-h":!0}),P(t)!=="svelte-1j6fakd"&&(t.textContent=l),a=C(o),i=w(o,"DIV",{class:!0});var h=$(i);for(let u=0;u<f.length;u+=1)f[u].l(h);h.forEach(g),o.forEach(g),n=C(s),J(c.$$.fragment,s),this.h()},h(){v(t,"class","border border-t-0 border-l-0 border-r-0"),v(i,"class","h-[12vh] w-full float-left overflow-y-scroll scroll-auto"),v(e,"class","border bg-white h-[15vh] p-1")},m(s,o){I(s,e,o),m(e,t),m(e,a),m(e,i);for(let h=0;h<f.length;h+=1)f[h]&&f[h].m(i,null);I(s,n,o),O(c,s,o),_=!0},p(s,[o]){if(o&5){d=H(s[0]);let u;for(u=0;u<d.length;u+=1){const p=_e(s,d,u);f[u]?f[u].p(p,o):(f[u]=pe(p),f[u].c(),f[u].m(i,null))}for(;u<f.length;u+=1)f[u].d(1);f.length=d.length}const h={};o&2&&(h.api=s[1]),c.$set(h)},i(s){_||(W(c.$$.fragment,s),_=!0)},o(s){F(c.$$.fragment,s),_=!1},d(s){s&&(g(e),g(n)),te(f,s),K(c,s)}}}function De(r,e,t){let{api_list:l=[]}=e,a={id:0,srv_id:0,api_name:"",api_content:"",api_param:[],test_count:0,is_inuse:"Y"};G(()=>{console.log(l)});const i=n=>{n.preventDefault();const c=n.target.getAttribute("value");t(1,a=l.find(_=>_.api_name===c)),console.log(a)};return r.$$set=n=>{"api_list"in n&&t(0,l=n.api_list)},[l,a,i]}class Le extends B{constructor(e){super(),U(this,e,De,Ce,j,{api_list:0})}}function ve(r,e,t){const l=r.slice();return l[3]=e[t],l}function me(r){let e,t,l,a,i,n,c,_=r[3].srv_name+"",d,f,s,o,h;return{c(){e=b("label"),t=b("input"),c=y(),d=A(_),f=y(),this.h()},l(u){e=w(u,"LABEL",{for:!0});var p=$(e);t=w(p,"INPUT",{type:!0,name:!0,id:!0,"data-srv_id":!0,class:!0}),c=C(p),d=q(p,_),f=C(p),p.forEach(g),this.h()},h(){v(t,"type","radio"),v(t,"name","srvlist"),v(t,"id",l=r[3].id),t.value=a=r[3].srv_name,t.checked=i=r[3].id=="1",v(t,"data-srv_id",n=r[3].id),v(t,"class","border text-left w-auto p-0.5 hover:text-white hover:bg-red-500 focus:bg-red-600 focus:text-white rounded-sm"),v(e,"for",s=r[3].id)},m(u,p){I(u,e,p),m(e,t),m(e,c),m(e,d),m(e,f),o||(h=M(t,"click",r[2]),o=!0)},p(u,p){p&1&&l!==(l=u[3].id)&&v(t,"id",l),p&1&&a!==(a=u[3].srv_name)&&(t.value=a),p&1&&i!==(i=u[3].id=="1")&&(t.checked=i),p&1&&n!==(n=u[3].id)&&v(t,"data-srv_id",n),p&1&&_!==(_=u[3].srv_name+"")&&R(d,_),p&1&&s!==(s=u[3].id)&&v(e,"for",s)},d(u){u&&g(e),o=!1,h()}}}function Ve(r){let e,t,l="SRV LIST:",a,i,n,c,_,d,f=H(r[0]),s=[];for(let o=0;o<f.length;o+=1)s[o]=me(ve(r,f,o));return _=new Le({props:{api_list:r[1].api_list}}),{c(){e=b("div"),t=b("span"),t.textContent=l,a=y(),i=b("div");for(let o=0;o<s.length;o+=1)s[o].c();n=y(),c=b("div"),z(_.$$.fragment),this.h()},l(o){e=w(o,"DIV",{class:!0});var h=$(e);t=w(h,"SPAN",{class:!0,"data-svelte-h":!0}),P(t)!=="svelte-11uywqa"&&(t.textContent=l),a=C(h),i=w(h,"DIV",{class:!0});var u=$(i);for(let E=0;E<s.length;E+=1)s[E].l(u);u.forEach(g),h.forEach(g),n=C(o),c=w(o,"DIV",{class:!0});var p=$(c);J(_.$$.fragment,p),p.forEach(g),this.h()},h(){v(t,"class","border-t-0 border-l-0 border-r-0 border"),v(i,"class","flex flex-col"),v(e,"class","border w-[12vw] p-1"),v(c,"class","border w-[90vw] ml-1")},m(o,h){I(o,e,h),m(e,t),m(e,a),m(e,i);for(let u=0;u<s.length;u+=1)s[u]&&s[u].m(i,null);I(o,n,h),I(o,c,h),O(_,c,null),d=!0},p(o,[h]){if(h&5){f=H(o[0]);let p;for(p=0;p<f.length;p+=1){const E=ve(o,f,p);s[p]?s[p].p(E,h):(s[p]=me(E),s[p].c(),s[p].m(i,null))}for(;p<s.length;p+=1)s[p].d(1);s.length=f.length}const u={};h&2&&(u.api_list=o[1].api_list),_.$set(u)},i(o){d||(W(_.$$.fragment,o),d=!0)},o(o){F(_.$$.fragment,o),d=!1},d(o){o&&(g(e),g(n),g(c)),te(s,o),K(_)}}}function Se(r,e,t){let l=[],a={id:"",srv_name:"",default_hdr:"",api_list:[]};return G(async()=>{const c=await(await fetch("http://10.8.3.125:8082/api/srv/list",{method:"GET"})).json();t(0,l=c),console.log(l),t(1,a=l[0])}),[l,a,n=>{let c=n.target.dataset.srv_id;t(1,a=l[c-1])}]}class Te extends B{constructor(e){super(),U(this,e,Se,Ve,j,{})}}function Ae(r){let e,t,l;return t=new Te({}),{c(){e=b("div"),z(t.$$.fragment),this.h()},l(a){e=w(a,"DIV",{class:!0});var i=$(e);J(t.$$.fragment,i),i.forEach(g),this.h()},h(){v(e,"class","flex flex-row justify-start border w-full h-screen p-1")},m(a,i){I(a,e,i),O(t,e,null),l=!0},p:ee,i(a){l||(W(t.$$.fragment,a),l=!0)},o(a){F(t.$$.fragment,a),l=!1},d(a){a&&g(e),K(t)}}}function qe(r){let e="";return G(async()=>{e=await(await fetch("http://10.8.3.125:8082/api/test/hello",{method:"GET"})).json(),console.log(e)}),[]}class je extends B{constructor(e){super(),U(this,e,qe,Ae,j,{})}}export{je as component};
