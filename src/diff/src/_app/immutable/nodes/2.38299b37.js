import{s as Se,n as me,r as ye,o as Ve}from"../chunks/scheduler.e108d1fd.js";import{S as De,i as Ae,g as n,m as H,s as S,h as i,j as g,n as L,f as p,c as y,x as ge,k as v,a as ce,y as t,z as ie,o as $,A as Ee,B as be}from"../chunks/index.1c70bbaf.js";import{e as le}from"../chunks/each.e59479a4.js";function we(c,e,s){const o=c.slice();return o[9]=e[s],o[11]=s,o}function Ie(c,e,s){const o=c.slice();return o[12]=e[s],o}function Te(c){let e,s=c[12].srv_name+"",o,d,_;return{c(){e=n("option"),o=H(s),this.h()},l(f){e=i(f,"OPTION",{});var a=g(e);o=L(a,s),a.forEach(p),this.h()},h(){e.__value=d=c[12].id,be(e,e.__value),e.selected=_=c[12].id==localStorage.getItem("selected_srv_id")},m(f,a){ce(f,e,a),t(e,o)},p(f,a){a&2&&s!==(s=f[12].srv_name+"")&&$(o,s),a&2&&d!==(d=f[12].id)&&(e.__value=d,be(e,e.__value)),a&2&&_!==(_=f[12].id==localStorage.getItem("selected_srv_id"))&&(e.selected=_)},d(f){f&&p(e)}}}function Ne(c){let e,s,o=c[11]+1+"",d,_,f,a=c[9].api_name+"",O,I,V,h=c[9].api_content+"",m,E,P,C=c[9].test_count+"",M,D;return{c(){e=n("tr"),s=n("td"),d=H(o),_=S(),f=n("td"),O=H(a),I=S(),V=n("td"),m=H(h),E=S(),P=n("td"),M=H(C),D=S(),this.h()},l(T){e=i(T,"TR",{});var u=g(e);s=i(u,"TD",{class:!0});var J=g(s);d=L(J,o),J.forEach(p),_=y(u),f=i(u,"TD",{class:!0});var R=g(f);O=L(R,a),R.forEach(p),I=y(u),V=i(u,"TD",{class:!0});var U=g(V);m=L(U,h),U.forEach(p),E=y(u),P=i(u,"TD",{class:!0});var N=g(P);M=L(N,C),N.forEach(p),D=y(u),u.forEach(p),this.h()},h(){v(s,"class","border text-center"),v(f,"class","border"),v(V,"class","border"),v(P,"class","border text-center")},m(T,u){ce(T,e,u),t(e,s),t(s,d),t(e,_),t(e,f),t(f,O),t(e,I),t(e,V),t(V,m),t(e,E),t(e,P),t(P,M),t(e,D)},p(T,u){u&1&&a!==(a=T[9].api_name+"")&&$(O,a),u&1&&h!==(h=T[9].api_content+"")&&$(m,h),u&1&&C!==(C=T[9].test_count+"")&&$(M,C)},d(T){T&&p(e)}}}function Pe(c){let e,s,o,d,_,f,a,O,I,V,h,m,E,P='<div>API CONTENT:</div> <div><input class="border w-full" id="api_content" name="api_content" placeholder="Enter the Api Content."/></div>',C,M,D,T,u,J,R,U,N,W,k,j,de='<th class="w-[2vw] text-center">#</th> <th class="w-[10vw]">API_NAME</th> <th>API CONTENT</th> <th class="w-[6vw] text-center">TEST CNT</th>',se,re,ae,oe,x,Q,X=(c[2]?JSON.stringify(c[2],null,4):"")+"",ee,ne,_e,z=le(c[1]),b=[];for(let r=0;r<z.length;r+=1)b[r]=Te(Ie(c,z,r));let G=le(c[0]),w=[];for(let r=0;r<G.length;r+=1)w[r]=Ne(we(c,G,r));return{c(){e=n("div"),s=n("div"),o=n("div"),d=n("div"),_=n("div"),f=H(`SRV NAME:

					`),a=n("select");for(let r=0;r<b.length;r+=1)b[r].c();O=S(),I=n("input"),V=S(),h=n("hr"),m=S(),E=n("div"),E.innerHTML=P,C=S(),M=n("div"),D=n("div"),T=H(`SRV NAME:
				`),u=n("input"),J=S(),R=n("input"),U=S(),N=n("div"),W=n("div"),k=n("table"),j=n("tr"),j.innerHTML=de,se=S();for(let r=0;r<w.length;r+=1)w[r].c();re=S(),ae=n("hr"),oe=S(),x=n("div"),Q=n("pre"),ee=H(X),this.h()},l(r){e=i(r,"DIV",{class:!0});var A=g(e);s=i(A,"DIV",{class:!0});var l=g(s);o=i(l,"DIV",{class:!0});var q=g(o);d=i(q,"DIV",{});var F=g(d);_=i(F,"DIV",{});var Y=g(_);f=L(Y,`SRV NAME:

					`),a=i(Y,"SELECT",{name:!0,id:!0,class:!0});var ve=g(a);for(let B=0;B<b.length;B+=1)b[B].l(ve);ve.forEach(p),O=y(Y),I=i(Y,"INPUT",{type:!0,class:!0}),Y.forEach(p),V=y(F),h=i(F,"HR",{}),m=y(F),E=i(F,"DIV",{"data-svelte-h":!0}),ge(E)!=="svelte-4llspp"&&(E.innerHTML=P),F.forEach(p),q.forEach(p),C=y(l),M=i(l,"DIV",{class:!0});var he=g(M);D=i(he,"DIV",{});var Z=g(D);T=L(Z,`SRV NAME:
				`),u=i(Z,"INPUT",{type:!0,class:!0}),J=y(Z),R=i(Z,"INPUT",{class:!0,id:!0,name:!0,placeholder:!0}),Z.forEach(p),he.forEach(p),l.forEach(p),U=y(A),N=i(A,"DIV",{class:!0});var K=g(N);W=i(K,"DIV",{class:!0});var ue=g(W);k=i(ue,"TABLE",{class:!0});var te=g(k);j=i(te,"TR",{class:!0,"data-svelte-h":!0}),ge(j)!=="svelte-7flsy6"&&(j.innerHTML=de),se=y(te);for(let B=0;B<w.length;B+=1)w[B].l(te);te.forEach(p),ue.forEach(p),re=y(K),ae=i(K,"HR",{}),oe=y(K),x=i(K,"DIV",{class:!0});var fe=g(x);Q=i(fe,"PRE",{});var pe=g(Q);ee=L(pe,X),pe.forEach(p),fe.forEach(p),K.forEach(p),A.forEach(p),this.h()},h(){v(a,"name","srv_list"),v(a,"id","srv_list"),v(a,"class","ml-5 mr-5"),v(I,"type","submit"),I.value="NEW API",v(I,"class","border pr-4 pl-4 bg-red-600 text-white float-right rounded-sm"),v(o,"class","border w-[79vw] h-57"),v(u,"type","submit"),u.value="NEW SRV",v(u,"class","border pr-4 pl-4 bg-orange-600 text-white float-right rounded-sm"),v(R,"class","border w-full"),v(R,"id","srv_name"),v(R,"name","srv_name"),v(R,"placeholder","Enter the Srv Name."),v(M,"class","border w-[29vw] h-57"),v(s,"class","border bg-white w-full h-60 flex flex-row justify-between pt-1 pl-1"),v(j,"class","text-left"),v(k,"class","w-full border border-separate"),v(W,"class","h-[44vh] overflow-y-scroll border"),v(x,"class","h-[28vh] overflow-y-scroll text-sm p-1"),v(N,"class","border bg-white w-full h-[74vh]"),v(e,"class","border w-full h-screen p-1 bg-gray-200")},m(r,A){ce(r,e,A),t(e,s),t(s,o),t(o,d),t(d,_),t(_,f),t(_,a);for(let l=0;l<b.length;l+=1)b[l]&&b[l].m(a,null);t(_,O),t(_,I),t(d,V),t(d,h),t(d,m),t(d,E),t(s,C),t(s,M),t(M,D),t(D,T),t(D,u),t(D,J),t(D,R),t(e,U),t(e,N),t(N,W),t(W,k),t(k,j),t(k,se);for(let l=0;l<w.length;l+=1)w[l]&&w[l].m(k,null);t(N,re),t(N,ae),t(N,oe),t(N,x),t(x,Q),t(Q,ee),ne||(_e=[ie(a,"change",c[5]),ie(I,"click",c[3]),ie(u,"click",c[4])],ne=!0)},p(r,[A]){if(A&2){z=le(r[1]);let l;for(l=0;l<z.length;l+=1){const q=Ie(r,z,l);b[l]?b[l].p(q,A):(b[l]=Te(q),b[l].c(),b[l].m(a,null))}for(;l<b.length;l+=1)b[l].d(1);b.length=z.length}if(A&1){G=le(r[0]);let l;for(l=0;l<G.length;l+=1){const q=we(r,G,l);w[l]?w[l].p(q,A):(w[l]=Ne(q),w[l].c(),w[l].m(k,null))}for(;l<w.length;l+=1)w[l].d(1);w.length=G.length}A&4&&X!==(X=(r[2]?JSON.stringify(r[2],null,4):"")+"")&&$(ee,X)},i:me,o:me,d(r){r&&p(e),Ee(b,r),Ee(w,r),ne=!1,ye(_e)}}}function Me(c,e,s){let o=[],d=[],_="";const f=()=>{const h=document.getElementById("srv_list");let m=document.getElementById("api_content");console.log(h.value,m.value),O(Number(h.value),m.value.toUpperCase()),m.value=""},a=()=>{let h=document.getElementById("srv_name");console.log(h.value),I(h.value),h.value=""},O=async(h,m)=>{s(2,_="");const P=await(await fetch("http://localhost:8082/api/add",{method:"POST",body:JSON.stringify({srv_id:h,api_content:m})})).json();s(2,_=P),window.location.reload()},I=async h=>{s(2,_="");const E=await(await fetch("http://localhost:8082/api/srv/add",{method:"POST",body:JSON.stringify({srv_name:h})})).json();s(2,_=E)},V=h=>{s(2,_=""),localStorage.removeItem("selected_srv_id");let m=h.currentTarget.value;localStorage.setItem("selected_srv_id",m),s(0,o=d.filter(E=>E.id==m)[0].api_list),console.log(`selected_srv_data:
`,o)};return Ve(async()=>{const m=await(await fetch("http://localhost:8082/api/srv/list",{method:"GET"})).json();s(1,d=m);const E=Number(localStorage.getItem("selected_srv_id"));s(0,o=E?d[E-1].api_list:d[0].api_list)}),[o,d,_,f,a,V]}class ke extends De{constructor(e){super(),Ae(this,e,Me,Pe,Se,{})}}export{ke as component};