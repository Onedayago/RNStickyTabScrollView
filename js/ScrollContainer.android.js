
import React, {useRef, useState, forwardRef, useImperativeHandle} from "react";
import {Text, View, TouchableOpacity, Animated, ScrollView} from "react-native";
import RNScrollView from "rn-scrollview/js/RNScrollViewNativeComponent";
import PropTypes from 'prop-types';

const ScrollContainerIos = forwardRef((props, ref) => {

    const {containerHeight, containerWidth, Header, data, Tab, PageContent, onPageChange} = props;
    const [stickyHeight, setStickyHeight] = useState(0);
    const [tabHeight, setTabHeight] = useState(0);
    const tabScroll = useRef(null);

    useImperativeHandle(ref,()=>({
        setPage: (index)=>{
            tabScroll.current.scrollTo({
                x: index*containerWidth,
                animated: true,
            })
        }
    }))

    const renderHeader = () => {
        return(
            <View onLayout={(e)=>{
                setStickyHeight(e.nativeEvent.layout.height);
            }}>
                {Header?.()}
            </View>
        )
    }

    const renderPage = (item, index) => {
        return(
            <View style={{width: containerWidth, height: containerHeight, overflow: 'hidden'}}  key={index}>
                <RNScrollView style={{width: containerWidth, height: containerHeight}} >
                    {PageContent?.(item, index)}
                </RNScrollView>
            </View>

        )
    }

    const renderContent = () => {
        return(
            <ScrollView
                horizontal={true}
                pagingEnabled={true}
                ref={tabScroll}
                onMomentumScrollEnd={(e)=>{
                    onPageChange(Math.round(e.nativeEvent.contentOffset.x/containerWidth));
                }}
            >
                <View style={{flexDirection: 'row', height: containerHeight}}>
                    {
                        data.map((item, index)=>{
                            return renderPage(item, index);
                        })
                    }
                </View>
            </ScrollView>
        )
    }

    const renderTab = () => {
        return(
            <View style={{flexDirection: 'row'}} onLayout={(e)=>{
                setTabHeight(e.nativeEvent.layout.height);
            }}>
                {Tab?.()}
            </View>
        )
    }

    return(
        <View style={{width: containerWidth, height: containerHeight+tabHeight, overflow: 'hidden'}}>
            <RNScrollView
                style={{width: containerWidth, height: containerHeight+tabHeight}}
                stickyHeight={stickyHeight}
                showsIndicator={false}
                bounce={false}
            >
                <View style={{backgroundColor: 'red'}}>
                    {renderHeader()}
                    {renderTab()}
                    {renderContent()}
                </View>
            </RNScrollView>
        </View>
    )
});

ScrollContainerIos.defaultProps = {
    containerHeight: 0,
    containerWidth: 0,
    Header: ()=>{},
    Tab: ()=>{},
    PageContent: ()=>{},
    data: [],
    onPageChange: ()=>{},
}

ScrollContainerIos.propTypes = {
    containerHeight: PropTypes.number.isRequired,
    containerWidth: PropTypes.number.isRequired,
    Header: PropTypes.func.isRequired,
    data: PropTypes.array.isRequired,
    Tab: PropTypes.func.isRequired,
    PageContent: PropTypes.func.isRequired,
    onPageChange: PropTypes.func,
}

export default ScrollContainerIos;
