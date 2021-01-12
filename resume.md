---
layout: pageNoFooter
title: Resume
permalink: /resume/
---

<div class="resumeHeaderWrapper">
  <div>
    <ul class="contact-list">
      <li class="p-name">
        {%- if site.author -%}
          {{ site.author | escape }}
        {%- else -%}
          {{ site.title | escape }}
        {%- endif -%}
        </li>
        {%- if site.email -%}
        <li><a class="u-email" href="mailto:{{ site.email }}">{{ site.email }}</a></li>
        {%- endif -%}
    </ul>
    {%- include social.html -%}
  </div>
  <p>{{- site.description | escape -}}</p>
</div>

## Skills

<div class="autoTable3">
  <div>
    <span>C++</span>
    <div class="meter">
      <span style="width: 50%"/>
    </div>
  </div>
  <div>
    <span>Qt</span>
    <div class="meter">
      <span style="width: 50%"/>
    </div>
  </div>
  <div>
    <span>Rust</span>
    <div class="meter">
      <span style="width: 50%"/>
    </div>
  </div>
  <div>
    <span>Valgrind</span>
    <div class="meter">
      <span style="width: 25%"/>
    </div>
  </div>
    <div>
    <span>GDB</span>
    <div class="meter">
      <span style="width: 25%"/>
    </div>
  </div>
  <div>
    <span>Swift</span>
    <div class="meter">
      <span style="width: 100%"/>
    </div>
  </div>
  <div>
    <span>iOS</span>
    <div class="meter">
      <span style="width: 100%"/>
    </div>
  </div>
  <div>
    <span>Objective-C</span>
    <div class="meter">
      <span style="width: 100%"/>
    </div>
  </div>
  <div>
    <span>Functional programming</span>
    <div class="meter">
      <span style="width: 50%"/>
    </div>
  </div>
  <div>
    <span>Haskell</span>
    <div class="meter">
      <span style="width: 25%"/>
    </div>
  </div>
  <div>
    <span>Category theory</span>
    <div class="meter">
      <span style="width: 25%"/>
    </div>
  </div>
  <div>
    <span>SQL</span>
    <div class="meter">
      <span style="width: 50%"/>
    </div>
  </div>
</div>
<br>

## Work experience

### FREENOW

 <table class="innerBorderTable">
  <col width="27%">
  <col width="17%">
  <tr>
    <td>Sept. 2018 – Sept. 2020</td>
    <td>iOS Developer</td>
    <td><p>At FREENOW I developed, tested, released and monitored new key business features that were launched internationally to thousands of drivers.
    I worked in a cross functional team developing new features and maintaining legacy code.</p>
    
    <p>The app is based on the <a href="https://github.com/freenowtech/Sensor">Sensor</a> reactive
    architecture, based on RxSwift. I fixed bugs and improved and developed new and existing features for the architecture supporting library.</p>
    </td>
  </tr>
  <tr>
    <td>Jan. 2020 – June 2020</td>
    <td>Back-end Developer</td>
    <td><p>I joined the release tooling team, a newly formed team with the mission to
    develop a back-end service that automates our apps release process.</p>

    <p>I developed the architecture of the service based on Spring, Hibernate, Kotlin and Arrow using functional programming patterns.</p>
    </td>
  </tr>
</table>

### Clubberize

 <table class="innerBorderTable">
  <col width="27%">
  <col width="17%">
  <tr>
    <td>Jan. 2018 – June 2018</td>
    <td>iOS Developer</td>
    <td><p>At Clubberize I lead the development of the app. I developed, improved and tested their location services,
     which use geofencing and beacons, Branch.io deep links
      and push notifications.</p></td>
  </tr>
</table>

### Basetis

 <table class="innerBorderTable">
  <col width="27%">
  <col width="17%">
  <tr>
    <td>Apr. 2016 – Dec. 2018</td>
    <td>iOS Developer</td>
    <td><p>At Basetis I worked in several iOS projects for several clients.
    I also worked as a QA on an electronic voting project for a client.</p></td>
  </tr>
</table>

### Everis

 <table class="innerBorderTable">
  <col width="27%">
  <tr>
    <td>Oct. 2015 – Mar. 2016</td>
    <td>iOS Developer intern</td>
  </tr>
</table>

## Education & Training

 <table class="innerBorderTable">
  <tr>
    <td>May 2017</td>
    <td>ISTQB Certified Tester Foundation Level</td>
    <td>ISTQB International Software Testing Qualifications Board</td>
  </tr>
  <tr>
    <td>2011 - 2019</td>
    <td>Degree in Mathematics (Unfinished)</td>
    <td>Universitat Politècnica de Catalunya</td>
  </tr>
  <tr>
    <td>2009 - 2010</td>
    <td>Degree in Informatics Eng. (1st course)</td>
    <td>Universitat Politècnica de Catalunya</td>
  </tr>
</table>

## Languages

<div class="autoTable3">
  <div>
    <span>English</span>
    <div class="meter">
      <span style="width: 80%"/>
    </div>
  </div>
  <div>
    <span>Spanish</span>
    <div class="meter">
      <span style="width: 100%"/>
    </div>
  </div>
  <div>
    <span>Catalan</span>
    <div class="meter">
      <span style="width: 100%"/>
    </div>
  </div>
  <div>
    <span>Italian</span>
    <div class="meter">
      <span style="width: 10%"/>
    </div>
  </div>
</div>
<br>

## Open source contributions

 <table class="innerBorderTable">
  <col width="27%">
  <tr>
    <th>
      Project
    </th>
    <th>
      Contributions
    </th>
  </tr>
  <tr>
    <td>
      <p><a href="https://www.mixxx.org">Mixxx</a></p>
      <p>Dj software (C++)</p>
    </td>
    <td>
      <ul>
      <li>Moving interquartile mean to calculate BPM from user taps<sup><a href="https://github.com/mixxxdj/mixxx/pull/450">[1]</a></sup></li>
      <li>UI improvements<sup><a href="https://github.com/mixxxdj/mixxx/pull/917">[1]</a><a href="https://github.com/mixxxdj/mixxx/pull/682">[2]</a><a href="https://github.com/mixxxdj/mixxx/pull/678">[3]</a><a href="https://github.com/mixxxdj/mixxx/pull/674">[4]</a><a href="https://github.com/mixxxdj/mixxx/pull/668">[5]</a><a href="https://github.com/mixxxdj/mixxx/pull/666/">[6]</a></sup></li>
      <li>Little tweaks to audio effects<sup><a href="https://github.com/mixxxdj/mixxx/pull/1502">[1]</a><a href="https://github.com/mixxxdj/mixxx/pull/733">[2]</a><a href="https://github.com/mixxxdj/mixxx/pull/1260">[3]</a></sup></li>
      <li><a href="https://github.com/mixxxdj/mixxx/pulls?q=is%3Apr+author%3Aferranpujolcamins">And more...</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://gitlab.com/uklotzde/aoide-rs/">Aoide</a></p>
      <p>A distributed music library management system (Rust)</p>
    </td>
    <td>
      <ul>
      <li>Allow to build a search query with a binary tree of filters and "and" and "or" combinations<sup><a href="https://gitlab.com/uklotzde/aoide-rs/-/commit/30027b8d0f546a9161a2277149b356892a3e3104">[1]</a></sup></li>
      <li><a href="https://gitlab.com/uklotzde/aoide-rs/-/commits/development?author=Ferran%20Pujol%20Camins">And more...</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://github.com/ferranpujolcamins/aoide-iTunes">Aoide iTunes</a></p>
      <p>An Aoide client to retrieve iTunes library metadata (Swift)</p>
    </td>
    <td>
      Project creator
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://github.com/davecom/SwiftGraph">SwiftGraph</a></p>
      <p>Graph data structures and algorithms library (Swift)</p>
    </td>
    <td>
      <ul>
      <li>DFS and BFS generalizations<sup><a href="https://github.com/davecom/SwiftGraph/pull/58">[1]</a><a href="https://github.com/davecom/SwiftGraph/pull/57">[2]</a></sup></li>
      <li>Constructors for star and complete graphs<sup><a href="https://github.com/davecom/SwiftGraph/pull/46">[1]</a><a href="https://github.com/davecom/SwiftGraph/pull/47">[2]</a></sup></li>
      <li>UniqueElementsGraph and graph union<sup><a href="https://github.com/davecom/SwiftGraph/pull/40">[1]</a></sup></li>
      <li>Performance improvements<sup><a href="https://github.com/davecom/SwiftGraph/pull/56">[1]</a><a href="https://github.com/davecom/SwiftGraph/pull/53">[2]</a><a href="https://github.com/davecom/SwiftGraph/pull/52">[3]</a><a href="https://github.com/davecom/SwiftGraph/pull/51">[4]</a><a href="https://github.com/davecom/SwiftGraph/pull/49">[5]</a></sup></li>
      <li><a href="https://github.com/davecom/SwiftGraph/pulls?q=+is%3Apr+author%3Aferranpujolcamins+">And more...</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://bow-swift.io/">Bow</a></p>
      <p>Functional programming library (Swift)</p>
    </td>
    <td>
      <ul>
      <li>Rank-N polymorphism documentation<sup><a href="https://bow-swift.io/docs/fp-concepts/rank-n-polymorphism/">[1]</a><a href="https://github.com/bow-swift/bow/pull/622">[2]</a></sup></li>
      <li>New Exists type encoding the notion of existential type used to improve Coyoneda implementation<sup><a href="https://github.com/bow-swift/bow/pull/623">[1]</a></sup></li>
      <li>Program type for free-er monads<sup><a href="https://github.com/bow-swift/bow/pull/634">[1]</a></sup></li>
      <li>Multi-way tree data type and its usual typeclass instances<sup><a href="https://github.com/bow-swift/bow/pull/626">[1]</a></sup></li>
      <li>Functor, Applicative and Monad instances for Trampoline<sup><a href="https://github.com/bow-swift/bow/pull/636">[1]</a></sup></li>
      <li>MonadTrans and ComonadTrans typeclasses and its laws<sup><a href="https://github.com/bow-swift/bow/pull/645">[1]</a></sup></li>
      <li><a href="https://github.com/bow-swift/bow/pulls?q=+is%3Apr+author%3Aferranpujolcamins+">And more...</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://github.com/pointfreeco/swift-snapshot-testing/">Swift Snapshot Testing</a></p>
      <p>Library for snapshot testing (Swift)</p>
    </td>
    <td>
      <ul>
      <li>Separate file content transformations from file IO so we can write unit tests<sup><a href="https://github.com/pointfreeco/swift-snapshot-testing/pull/232">[1]</a></sup></li>
      <li>Escape snapshot literals appropriately when they contain special characters<sup><a href="https://github.com/pointfreeco/swift-snapshot-testing/pull/231">[1]</a></sup></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://github.com/freenowtech/Sensor">Sensor</a></p>
      <p>Functional reactive architecture and supporting library (Swift)</p>
    </td>
    <td>
      <ul>
      <li>Sensor DSL to manage side effects in the reducer<sup><a href="https://github.com/freenowtech/Sensor/commits/0.2.0">[1]</a></sup></li>
      <li>SensorTest improvements and Sensor unit tests</li>
      <li>Add unique ID to effects so they can be triggered more than once</li>
      <li><a href="https://github.com/freenowtech/Sensor/commits/master">And more...</a></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <p><a href="https://github.com/NixOS/nixpkgs">nixpkgs</a></p>
      <p>A collection of software packages for Nix package manager</p>
    </td>
    <td>
      <ul>
      <li>Allow chromaprint library to be built on macOS<sup><a href="https://github.com/NixOS/nixpkgs/pull/98057">[1]</a></sup></li>
      </ul>
    </td>
  </tr>
</table>