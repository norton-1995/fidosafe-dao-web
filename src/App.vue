<template>
    <div>

        <section class="wrapper bg-gradient-primary">
            <div class="container pt-10 pt-md-14 pb-8">
                <div class="row gx-lg-8 gx-xl-12 gy-10">
                    <div class="col-lg-7">
                        <h2 class="lead lead-text">Проект Fidosafe - это <b>самый дружелюбный, удобный и гибкий веб мультисиг кошелек</b> для Everscale
                            подтверждением транзакций через браузер Surf. Уже сейчас вы можете ознакомиться с рабочей версией приложения <a
                                    href="https://fidosafe.com" target="_blank"><u>по этой ссылке</u></a> или посмотреть на пример работы сейфа <a href="https://app.fidosafe.com/#/0:61941ede2545603a3dce4236a27ac5a322646330ad452eac7295c8c5e568dbd4/transactions" target="_blank"><u>тут</u></a>. Несмотря на наши успехи, мы нуждается в финансовой
                            поддержке сообщества для реализации следующих направлений:<br/><br/>
                            <ul>
                                <li>Проведение технического аудита кода (28 000 EVER)</li>
                                <li>Применение последующих доработок</li>
                                <li>Поддержка TIP3 токенов</li>
                                <li>Возможность подключения бизнес-модулей статистики и отчетности</li>
                                <li>Вайт-лист на Tonswap, создание ликвидности, программы фарминга</li>
                            </ul>
                            Вместе мы создадим среду, в которой крипто-бизнесы смогут безопасно и удобно оперировать своими активами, а в более далекой
                            перспективе вместе создадим инструмент для доверительного управления активами частных лиц. <p class="mt-1">Если вы разделяете наши
                                идеи и ценности, мы приглашаем вас стать частью сообщества Fidosafe, приобретая или бесплатно получая токены проекта.</p>
                        </h2>
                    </div>
                    <!-- /column -->
                    <div class="col-md-10 offset-md-1 offset-lg-0 col-lg-5 text-lg-start">
                        <h1 class="display-1 mb-5 mx-md-n5 mx-lg-0">Распределение DAO токенов</h1>
                        <p class="small">{{ detailsMessage }}</p>
                        <div class="d-flex width-100 justify-content-between mb-3">
                            <div class="time-cell d-flex flex-column">
                                <div class="text-center">{{ rDate.rDays }}</div>
                                <div class="text-uppercase">дней</div>
                            </div>
                            <div class="time-cell d-flex flex-column">
                                <div class="text-center">{{ rDate.rHours }}</div>
                                <div class="text-uppercase">часов</div>
                            </div>
                            <div class="time-cell d-flex flex-column">
                                <div class="text-center">{{ rDate.rMinutes }}</div>
                                <div class="text-uppercase">минут</div>
                            </div>
                            <div class="time-cell d-flex flex-column">
                                <div class="text-center">{{ rDate.rSeconds }}</div>
                                <div class="text-uppercase">секунд</div>
                            </div>
                        </div>
                        <p class="lead fs-lg mb-2">
                            200 000 FIDO токенов айрдроп<br/>
                            <span class="small" v-if="actionStarted">Уже получено: {{ totalClaimed }}<br/></span>
                            800 000 FIDO токенов на продажу<br/>
                            <span class="small" v-if="actionStarted">Уже куплено: {{ totalSold }}<br/></span>
                            Продолжительность: 25 дней<br/>
                            <span class="small" v-if="actionStarted">Текущий бонус: +{{ floatProcent}}%<br/></span>
                        </p>
                    </div>
                    <!-- /column
                              <span><a class="btn btn-primary rounded-pill me-2" href="https://app.fidosafe.com" target="_blank">Go to App</a></span> &hellip; or <a href="https://test.fidosafe.com"><u>try it in test mode</u></a>.
                              -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->
        </section>
        <!-- /section -->
        <section class="wrapper bg-grad-primary" id="airdrop">
            <div class="container pt-6 pt-md-10">
                <div class="row mt-8">
                    <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-2">
                        <h3 class="display-4 mb-10 px-xl-10 text-white">Как получить айрдроп токенов FIDO?</h3>
                    </div>
                    <!-- /column -->
                </div>
                <!-- /.row -->
                <div class="position-relative">
                    <div class="shape rounded-circle bg-soft-blue rellax w-16 h-16" data-rellax-speed="1"
                         style="bottom: -0.5rem; right: -2.2rem; z-index: 0;"></div>
                    <div class="shape bg-dot primary rellax w-16 h-17" data-rellax-speed="1" style="top: -0.5rem; left: -2.5rem; z-index: 0;"></div>
                    <div class="row gx-md-5 gy-5">
                        <div class="col-12 p-0 p-md-2">
                            <div class="card shadow-lg">
                                <div class="card-body">
                                    <p class="mb-2">Каждый аккаунт, у которого было на 01.01.2022 11:00 UTC+0 на счету от 10 EVER до 10 000 EVER, имеет возможность
                                        бесплатно получить токены FIDO из расчета 1 EVER = 1 FIDO. Для этого необходимо прислать <b>2 EVER</b> на кошелек нашего
                                        контракта. Например, если у вас на момент создания слепка балансов было 127 EVER, мы пришлем вам 127 FIDO. </p>
                                    <p>Введите номер своего кошелька, чтобы посмотреть, сколько токенов вы сможете получить бесплатно.</p>
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="Номер кошелька, например, 0:723...eda"
                                               aria-label="Recipient's username" aria-describedby="button-check-claim" v-model="claimAddress">
                                        <button class="btn btn-primary" type="button" id="button-check-claim" v-on:click="checkClaim(claimAddress)">
                                            <i class="uil uil-search-alt" v-if="!isLoadingCheck"></i>
                                            <div class="spinner-grow spinner-grow-sm" role="status" v-if="isLoadingCheck">
                                            </div>
                                        </button>
                                    </div>
                                    <p v-if="claimMessage" class="display-3" v-bind:class="{'text-green': !this.isClaimed, 'text-grey': this.isClaimed}">{{ claimMessage }}
                                        <span v-if="this.isClaimed">(уже получено)</span></p>
                                    <p> При отправке 2 EVER на айрдроп адрес <b>укажите</b> в поле комментарий к транзакции слово <b><i>claim</i></b>. Иначе
                                        система будет считать, что <i>вы хотите купить токены</i>. </p>

                                    <p class="mt-4"><b>Кошелек нашего контракта:</b></p>
                                    <p><span id="claim-address" class="me-2 small">{{ accountAddress }}</span>
                                        <button class="btn btn-outline-secondary btn-sm ps-1 pe-1 pt-0 pb-0 copy-btn"
                                                data-clipboard-target="#claim-address"><i class="uil uil-copy-alt"></i></button>
                                    </p>

                                    <p>Если вы пользователь Surf, для айрдропа воспользуйтесь <a v-bind:href='"https://uri.ton.surf/transfer?address="+this.accountAddress+"&amount=2000000000&text=claim"' target="_blank"><u>этой ссылкой</u></a>.
                                    </p>

                                    <p class="mt-8">Пример трензакции в Surf:</p>
                                    <img src="./assets/img/assisting-image-comment.png" class="img-fluid img-frame">

                                </div>
                                <!--/.card-body -->
                            </div>
                            <!--/.card -->
                        </div>
                    </div>
                    <!--/.row -->
                </div>
                <!-- /.position-relative -->
            </div>
            <!-- /.container -->
        </section>
        <!-- /section -->
        <section class="wrapper bg-grad-primary" id="buytokens">
            <div class="container pt-14 pt-md-16">
                <div class="row">
                    <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-2">
                        <h3 class="display-4 mb-10 px-xl-10 text-white">Как купить токены FIDO?</h3>
                    </div>
                    <!-- /column -->
                </div>
                <!-- /.row -->
                <div class="position-relative">
                    <div class="shape rounded-circle bg-soft-blue rellax w-16 h-16" data-rellax-speed="1"
                         style="bottom: -0.5rem; right: -2.2rem; z-index: 0;"></div>
                    <div class="shape bg-dot primary rellax w-16 h-17" data-rellax-speed="1" style="top: -0.5rem; left: -2.5rem; z-index: 0;"></div>
                    <div class="row gx-md-5 gy-5">
                        <div class="col-12 p-0 p-md-2">
                            <div class="card shadow-lg">
                                <div class="card-body">
                                    <p>Вы можете купить токены FIDO из расчета 1 EVER = <b>10 FIDO</b> в течение срока действия акции (25 дней). Для этого вы
                                        отправляете нужное вам количество EVER на кошелек нашего контракта, а мы в ответном сообщении присылаем токены FIDO.
                                        Минимальная сумма транзакции 2 EVER. </p>
                                    <p><b>Кошелек нашего контракта:</b></p>
                                    <p><span id="buy-address" class="me-2 small">{{ this.accountAddress }}</span>
                                        <button class="btn btn-outline-secondary btn-sm ps-1 pe-1 pt-0 pb-0 copy-btn"
                                                data-clipboard-target="#buy-address"><i class="uil uil-copy-alt"></i></button>
                                    </p>

                                    <p class="mt-4 mb-8">Если вы пользователь Surf, для покупки воспользуйтесь <a v-bind:href='"https://uri.ton.surf/transfer?address="+this.accountAddress' target="_blank"><u>этой ссылкой</u></a>.
                                    </p>

                                    <h5> Получите до 25% токенов FIDO бонусом! </h5>
                                    <p>В первый день акции отправитель получит +25% FIDO токенов бесплатно, во второй день +24% и так далее ваш бонус будет
                                        уменьшаться, пока не дойдет до +1%. Таким образом, чем быстрее вы купите токены, тем больше будет размер вашего
                                        бонуса. </p>
                                    <p v-if="actionStarted">На сегодняшний день размер бонуса составляет: <span class="display-3 text-green">+{{ floatProcent }}%</span><br/>Торопитесь!
                                        Бонусный процент тает с каждым днем. </p>
                                </div>
                                <!--/.card-body -->
                            </div>
                            <!--/.card -->
                        </div>
                    </div>
                    <!--/.row -->
                </div>
                <!-- /.position-relative -->
            </div>
            <!-- /.container -->
        </section>
        <!-- /section -->
        <section class="wrapper bg-light" id="affiliate">
            <div class="container pt-14 pt-md-16">
                <div class="row">
                    <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-2">
                        <h3 class="display-4 mb-10 px-xl-10">Получите еще больше FIDO с нашей реферальной программой!</h3>
                    </div>
                    <!-- /column -->
                </div>
                <!-- /.row -->
                <div class="position-relative">
                    <div class="shape rounded-circle bg-soft-blue rellax w-16 h-16" data-rellax-speed="1"
                         style="bottom: -0.5rem; right: -2.2rem; z-index: 0;"></div>
                    <div class="shape bg-dot primary rellax w-16 h-17" data-rellax-speed="1" style="top: -0.5rem; left: -2.5rem; z-index: 0;"></div>
                    <div class="row gx-md-5 gy-5">
                        <div class="col-12 p-0 p-md-2">
                            <div class="card shadow-lg">
                                <div class="card-body">
                                    <p>Получите <b>+10% FIDO</b> от каждого перевода, который был осуществлен с вашим реферальным кодом. Ваш реферальный код
                                        присылается в обратном сообщении после вашей первой покупки токенов. Впишите свой реферальный код в поле ввода, и вы
                                        получите ссылку, которой можно делиться с друзьями и получать дополнительные токены FIDO. </p>
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="Номер, например, 1001"
                                               aria-label="Ваш реферальный номер, например, 1001" aria-describedby="button-build-link" v-model="affCode">
                                        <button class="btn btn-primary" type="button" id="button-build-link" v-on:click="genLink()"><i class="uil uil-link"></i></button>
                                    </div>
                                    <p v-if="affMessage">Ваша ссылка для Surf: <span id="afflink" class="small">{{ affMessage }}</span>
                                    <button class="btn btn-outline-secondary btn-sm ps-1 pe-1 pt-0 pb-0 copy-btn"
                                                data-clipboard-target="#afflink"><i class="uil uil-copy-alt"></i></button>
                                    </p>
                                    <p>Поделитесь этой ссылкой с друзьями и получите 10% FIDO токенов от суммы, приобретенной ими.</p>
                                </div>
                                <!--/.card-body -->
                            </div>
                            <!--/.card -->
                        </div>
                    </div>
                    <!--/.row -->
                </div>
                <!-- /.position-relative -->
            </div>
            <!-- /.container -->
        </section>
  <!-- /.content-wrapper -->
  <footer class="bg-navy text-inverse">
    <div class="container pt-15 pt-md-17 pb-13 pb-md-15">
      <div class="d-lg-flex flex-row align-items-lg-start">
        <h3 class="display-4 mb-6 mb-lg-0 pe-lg-4 text-white">Что такое FIDO токен и как мне проверить свой баланс?</h3>
        <div>
            <p class="lead">FIDO - это governance токен, который в дальнейшем позволит сообществу совместно управлять проектом Fidosafe и вносить свои инициативы в развитие проекта.
              Надеемся, что вместе у нас получится осуществить задуманное!
            </p>
            <p class="lead">
              FIDO - это TIP3 токен (стандарт, разработанный компанией Broxus). Вы можете проверить свой баланс в кошельке Crystal Wallet, добавив следующий адрес корневого токена:<br/>
              <span class="me-2 small word-break" id="root-contract-address">{{ rootTokenAddress }}</span>
              <button id="copy-address-btn" class="btn btn-outline-secondary btn-sm ps-1 pe-1 pt-0 pb-0 copy-btn" data-clipboard-target="#root-contract-address"><i class="uil uil-copy-alt"></i></button>
            </p>
        </div>
      </div>
      <!--/div -->
      <hr class="mt-11 mb-12" />
      <div class="row gy-6 gy-lg-0">
        <div class="col-md-4 col-lg-3">
          <div class="widget">
            <p class="mb-4">© 2021 Fidosafe. <br class="d-none d-lg-block" />All rights reserved.</p>
            <nav class="nav social social-white">
              <a href="#"><i class="uil uil-twitter"></i></a>
              <a href="#"><i class="uil uil-facebook-f"></i></a>
              <a href="#"><i class="uil uil-dribbble"></i></a>
              <a href="#"><i class="uil uil-instagram"></i></a>
              <a href="#"><i class="uil uil-youtube"></i></a>
            </nav>
            <!-- /.social -->
          </div>
          <!-- /.widget -->
        </div>
        <!-- /column -->
        <div class="col-md-4 col-lg-3">
          <div class="widget">
            <p class="">All Users of Fidosafe must understand the risks involved in Digital Assets management, and are recommended to exercise prudence and responsibly within their own capabilities.</p>
            <a href="mailto:#">norton1995@protonmail.com</a><br /> Telegram: @Iva4599
          </div>
          <!-- /.widget -->
        </div>
        <!-- /column -->
        <div class="col-md-4 col-lg-3">
          <div class="widget">
            <h4 class="widget-title text-white mb-3">Разделы</h4>
            <ul class="list-unstyled  mb-0">
              <li><a href="#airdrop">Айрдроп токенов</a></li>
              <li><a href="#buytokens">Купить токены</a></li>
              <li><a href="#affiliate">Реферальная программа</a></li>
              <li><a href="https://github.com/norton-1995/fidosafe-web" target="_blank">Github</a></li>
            </ul>
          </div>
          <!-- /.widget -->
        </div>
      </div>
      <!--/.row -->
    </div>
    <!-- /.container -->
  </footer>
    </div>
</template>
<script>
import { TonClient, signerNone } from '@tonclient/core';
import { libWeb } from '@tonclient/lib-web';
import { Account } from "@tonclient/appkit";
import { FidosafeDAOContract } from './contract_wrappers/FidosafeDAO';
import BigNumber from "bignumber.js";

export default {
    name: 'App',
    components: {},
    data: function () {
        return {
            account: null,
            claimAddress: "",
            claimMessage: "",
            isClaimed: false,
            maxTokens: 0,
            totalSold: 0,
            totalClaimed: 0,
            startTime: 0,
            endTime: 0,
            rDate: { rDays: 0, rHours: 0, rMinutes: 0, rSeconds: 0 },
            detailsMessage: 'До начала остается:',
            accountAddress: "0:21b8dc629218b253c2ee1ed9110a8c6bb1957bad82662a9b5675f663a38aa75f",
            rootTokenAddress: "0:79d3619e02cf58b85f47621356e44c41f968b2153cdf4fad0358123809782caf",
            floatProcent: 0,
            affCode: null,
            affMessage: '',
            isLoadingCheck: false
        }
    },
    mounted() {
        BigNumber.config({
            FORMAT: {
                groupSize: 3,
                groupSeparator: ' ',
                decimalSeparator: '.'
            },
        });
        TonClient.useBinaryLibrary(libWeb);
        const client = new TonClient({
            network: {
                endpoints: ["http://localhost"]
                //endpoints: ["net1.ton.dev", "net5.ton.dev"]
                //endpoints: ["main.ton.dev"]
            }
        });
        this.account = new Account(FidosafeDAOContract, {
            address: this.accountAddress,
            client,
            signer: signerNone(),
        });
        this.getDetails();

        setInterval(this.calculateRemainingDate, 1000);

    },
    methods: {
        async checkClaim(address) {
            this.isLoadingCheck = true;
            try {
                let result = await this.account.runLocal("getClaimerByAddress", { claimerAddress: address });
                let value = new BigNumber(parseInt(result.decoded.output.data.balance)).dividedBy(1e9).toFixed(2);
                this.isClaimed = result.decoded.output.data.claimed;
                this.claimMessage = `Вы можете получить ${ value } токенов FIDO`;
                this.isLoadingCheck = false;
            }
            catch (e) {
                console.log(e);
            }
            this.isLoadingCheck = false;
        },
        async getDetails() {
            let result = await this.account.runLocal("getDetails", {});
            this.maxTokens = new BigNumber(parseInt(result.decoded.output.data.maxTokens)).dividedBy(1e9).toFormat(0);
            this.totalSold = new BigNumber(parseInt(result.decoded.output.data.totalSold)).dividedBy(1e9).toFormat(0);
            this.totalClaimed = new BigNumber(parseInt(result.decoded.output.data.totalClaimed)).dividedBy(1e9).toFormat(0);
            this.startTime = parseInt(result.decoded.output.data.startTime);
            this.endTime = parseInt(result.decoded.output.data.endTime);
            this.floatProcent = parseInt(result.decoded.output.data.floatProcent);
        },
        calculateRemainingDate() {
            let now = Math.floor(Date.now() / 1000);
            if (this.startTime === 0 || now > this.endTime) {
                this.rDate.rDays = 0;
                this.rDate.rHours = 0;
                this.rDate.rMinutes = 0;
                this.rDate.rSeconds = 0;
                return;
            }
            let endDate = this.startTime;
            if (now > this.startTime) {
                endDate = this.endTime;
                this.detailsMessage = 'Акция закончится через:';
            }

            this.rDate.rDays = Math.floor((endDate - now) / (60 * 60 * 24));
            this.rDate.rHours = Math.floor(((endDate - now - this.rDate.rDays * 60 * 60 * 24) / (60 * 60)));
            this.rDate.rMinutes = Math.floor((endDate - now - this.rDate.rDays * 60 * 60 * 24 - this.rDate.rHours * 60 * 60) / 60);
            this.rDate.rSeconds = Math.floor(endDate - now - this.rDate.rDays * 60 * 60 * 24 - this.rDate.rHours * 60 * 60 - this.rDate.rMinutes * 60);
        },
        genLink() {
            this.affMessage =  `https://uri.ton.surf/transfer?address=${this.accountAddress}&amount=100000000000&text=${this.affCode}`
        }
    },
    computed: {
        actionStarted: function () {
            let now = Math.floor(Date.now() / 1000);
            if (this.startTime === 0) {
                return false;
            }
            if (now > this.endTime) {
                return false
            }
            return now > this.startTime;
        }
    }
}
</script>
<style>
.card-body {
    color: var(--bs-gray-900);
}
.text-grey {
    color: var(--bs-body-color);
}
.bg-grad-primary {
    background: linear-gradient(var(--bs-primary) 0%, rgba(0,0,0,0) 100%);
}
.form-control {
    background-color: rgba(16, 86, 82, 0.3) !important;
}
.word-break {
    word-break: break-all;
}
</style>